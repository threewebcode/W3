# Sketch: Detailed Technical Blueprint for JMT Integration into Sui 🔬

**Status:** Draft — deep technical sketch for implementation and engineering

This sketch expands the `design.md` with concrete technical details, pseudocode, data layouts, explicit algorithms, storage keys, RPC schemas, CLI commands, migration automations, and testing/benchmark requirements. It is intended for implementers to follow or adapt directly into code.

---

## Table of contents

- [Assumptions & scope](#assumptions--scope)
- [Core types & Rust sketches](#core-types--rust-sketches)
- [NodeStore schema & RocksDB layout](#nodestore-schema--rocksdb-layout)
- [JmtWriter apply_batch — algorithm & atomic commit](#jmtwriter-apply_batch--algorithm--atomic-commit)
- [JmtReader proof generation algorithm](#jmtreader-proof-generation-algorithm)
- [Proof format & serialization](#proof-format--serialization)
- [Checkpoint integration & commit sequence](#checkpoint-integration--commit-sequence)
- [Genesis bootstrap & non-genesis migration (detailed)](#genesis-bootstrap--non-genesis-migration-detailed)
- [Snapshot importer tool — spec & APIs](#snapshot-importer-tool--spec--apis)
- [RPC & JSON schemas](#rpc--json-schemas)
- [CLI tools & operational commands](#cli-tools--operational-commands)
- [Concurrency, caching, and perf optimizations](#concurrency-caching-and-perf-optimizations)
- [GC & pruning algorithms](#gc--pruning-algorithms)
- [Testing & property-based specifications](#testing--property-based-specifications)
- [Benchmarks & performance targets](#benchmarks--performance-targets)
- [Monitoring & alerts (metrics)](#monitoring--alerts-metrics)
- [Security and auditing](#security-and-auditing)
- [Rollout plan checklist & automation snippets](#rollout-plan-checklist--automation-snippets)

---

## Assumptions & scope

- A verified JMT algorithm exists (we may reuse or re-implement). This blueprint focuses on integration, persistence, RPC exposure, migration, and operational practices.
- Sui's existing storage is RocksDB via `sui-kvstore` (we will implement a NodeStore adaptor that uses the same DB).
- We will use Sui's canonical hash function unless operators decide to change; make it pluggable.


---

## Core types & Rust sketches

Include type sketches to reduce ambiguity when implementing.

```rust
// types used across the integration
pub type Version = u64; // monotonic tree version per apply_batch
pub type Hash = [u8; 32]; // or a newtype
pub type Key = Vec<u8>; // canonical key bytes for state
pub type Value = Vec<u8>; // binary value

// Update: either Insert(Key, Value) or Delete(Key)
pub enum Update {
    Insert(Key, Value),
    Delete(Key),
}

// NodeStore trait to be implemented by adapters
pub trait NodeStore: Send + Sync + 'static {
    /// Looks up a node blob by hash
    fn get_node(&self, node_hash: &Hash) -> Option<Vec<u8>>;
    /// Inserts a node; returns its hash
    fn put_node(&self, node_hash: Hash, node_bytes: Vec<u8>) -> Result<(), Error>;
    /// Persist mapping from version->root
    fn put_root(&self, version: Version, root: Hash) -> Result<(), Error>;
    fn get_root(&self, version: Version) -> Option<Hash>;
}

pub struct JmtWriter<S: NodeStore, H: HashAlgo> { store: Arc<S>, hasher: H, /* caches */ }
pub struct JmtReader<S: NodeStore, H: HashAlgo> { store: Arc<S>, hasher: H }

pub struct Proof { /* serialized nodes + leaf data + proof metadata */ }

pub trait HashAlgo { fn hash_node(&self, node_type: NodeType, children: &[Hash], key_partial: &[u8], value: Option<&[u8]>) -> Hash; }
```

Implementation note: make `Node` encoding deterministic (canonical encoding) for cross-language compatibility.

---

## NodeStore schema & RocksDB layout

Use a clear keyspace naming to avoid collisions and to enable easy replay / debugging.

Key format suggestions (binary prefixes):

- `prefix: 0x4A 0x4D 0x54` (ASCII JMT) followed by a one-byte namespace and then payload.
- `jmt/node/<hash>` -> node bytes  
  Key = JMT_PREFIX || 0x01 || node_hash(32)
- `jmt/root/<version>` -> root hash + metadata  
  Key = JMT_PREFIX || 0x02 || version(u64 big-endian)
- `jmt/meta/latest` -> latest version (u64)  
  Key = JMT_PREFIX || 0x03 || b"latest"
- `jmt/staging/<checkpoint_id>` -> serialized list of staged node hashes (for non-atomic commit)  
  Key = JMT_PREFIX || 0x04 || checkpoint_id

Values: store as length-prefixed TLV or CBOR. Keep it compact: small header + bytes.

Rationale: explicit big-endian versioning helps scanning ranges and supporting range-queries for pruning.

---

## JmtWriter apply_batch — algorithm & atomic commit

Goal: apply a batch of updates atomically and produce a new `Version` and `root_hash`.

High-level steps:
1. Convert keys to canonical nibble-encoded paths as JMT requires.
2. For each update (insert/delete), apply a path-based operation on an in-memory copy-on-write walker from the previous root.
3. Create modified nodes along the path; compute hashes bottom-up using `HashAlgo`.
4. Deduplicate produced nodes by hash and prepare a set of nodes to persist.
5. Persist nodes and the root atomically with the checkpoint; if atomic operations across DB not possible, use staging pattern.

Detailed pseudocode:

```pseudo
function apply_batch(updates):
    base_version = read_latest_version();
    scratch = new InMemoryMutations();

    for update in updates_sorted_by_key:
        path = encode_key_to_nibbles(update.key)
        mutate_path(scratch, path, update)

    // compute hashes bottom-up
    root_hash, new_nodes = compute_hashes(scratch, base_root_hash)

    // Persist using atomic approach
    txn = store.begin_txn() // if available
    for node_hash, node_bytes in new_nodes:
        txn.put(jmt/node/node_hash, node_bytes)
    txn.put(jmt/root/version+1, root_hash || metadata)
    txn.put(jmt/meta/latest, version+1)
    txn.commit()

    return version+1
```

Notes on sorting: sort updates by key to merge duplicate updates and minimize traversal cost.

Atomicity strategies:

- **Preferred:** use RocksDB single transaction to write node keys and the root key. This ensures atomic durability.
- **Fallback (staging):** write `jmt/staging/<checkpoint>` with list of node hashes and a `commit` flag. After successful persistence of root, set the `commit` flag. On startup, the node runs recovery that replays any staged commits.

Crash recovery invariants: ensure that any root referenced by a checkpoint has all nodes necessary to verify proofs present in NodeStore; if not, disable proof issuance for that version until nodes are repaired.

---

## JmtReader proof generation algorithm

Given a `key` and `version`, we need to produce an inclusion or non-inclusion proof.

Algorithm outline:
1. Load `root_hash` for `version` (from `jmt/root/version`). If missing, return NotFound.
2. Walk the path (nibble encoded) from root; at each internal node, include the sibling hashes necessary to recompute the parent hash.
3. For leaf inclusion: return the leaf's key, value, and list of sibling hashes; for non-inclusion: include the neighbor leaf and internal discriminators demonstrating absence.

Pseudo:

```pseudo
function prove(key, version):
    root = store.get_root(version)
    path = key_to_nibbles(key)
    cursor_hash = root
    proof_nodes = []

    while not leaf:
        node_bytes = store.get_node(cursor_hash)
        node = decode(node_bytes)
        add node (or subset) to proof_nodes

        if path branch exists: cursor_hash = child_for(path.byte)
        else: // missing branch
             return non_inclusion_proof(proof_nodes, context)

    // at leaf: return inclusion proof: leaf value + proof_nodes
```

Memory and bandwidth considerations: proof size equals O(height) nodes; compress nodes by only sending necessary child hashes and the target leaf payload.

---

## Proof format & serialization

Design goals:
- Compact for network transmission
- Stable cross-language (use consensus stable encodings: e.g., canonical CBOR or BCS)
- Indexed format to allow streaming large proofs

Suggested structure (JSON/CBOR/BCS-friendly):

```json
ProofResponse {
  "version": 1234,
  "root": "0x...",
  "key": "0x...",
  "value": "0x..." | null,
  "inclusion": true | false,
  "nodes": [ {"type": "internal", "nibble_branch":X, "children_hashes": [...]}, {"type":"leaf", "key":"0x..", "value":"0x.."} ]
}
```

Implementation note: use binary encoding for production RPCs (BCS / protobuf) with human-readable JSON options in debug mode.

---

## Checkpoint integration & commit sequence

Pseudocode for checkpoint producer integration (high level in the checkpointer):

```rust
fn produce_checkpoint(transactions) -> CheckpointSummary {
    let updates = collect_updates(transactions);

    // Apply updates to DB
    let db_txn = kvstore.begin_txn();
    for update in updates { apply_kv_update(db_txn, update); }
    // Prepare to commit JMT nodes too

    // Apply updates to JMT writer; JMT writer will return new version and root
    let jmt_version = jmt_writer.apply_batch(&updates)?;
    let jmt_root = jmt_writer.root(jmt_version)?;

    // persist everything atomically if possible
    if kvstore.supports_txn() {
        for node in jmt_writer.staged_nodes() { kvstore.put(node.key, node.value); }
        kvstore.put(CheckpointKey(checkpoint_id), serialized_checkpoint_summary);
        kvstore.commit_txn();
    } else {
        // do two-phase commit: stage node writes and mark completion
        write_staging_info(checkpoint_id, staged_hashes);
        commit_nodes();
        write_checkpoint_summary();
        mark_staging_complete(checkpoint_id);
    }

    return checkpoint_summary_with_jmt_fields;
}
```

Important: ensure writers lock the sequence so concurrent checkpoint producers don't clash on version numbering.

---

## Genesis bootstrap & Non-Genesis migration (detailed)

### Genesis bootstrap

- On chain bootstrap, choose `jmt_version=0` for the genesis root (empty tree) or compute from initial state (if genesis defines state).
- Persist nodes and root into storage; include in genesis checkpoint summary all nodes necessary if desired (though empty root requires no nodes).

### Non-Genesis migration — Snapshot importer detailed steps

This is the recommended route for existing mainnets.

1. **Select a canonical checkpoint H** where JMT activation will occur.
2. **Export** deterministic snapshot at H:
   - Export (key, value) pairs for all relevant Sui state trees (e.g., objects, modules) sorted by canonical key bytes.
   - For each key, ensure stable encoding; provide a canonical manifest with hash and signature.

3. **Import into JMT** using `sui-jmt-import`:
   - Stream sorted keys into importer.
   - Use an `InMemoryJmtWriter` to repeatedly insert keys in sorted order; inserting in sorted order can be optimized using batched writes to avoid rebuilding common prefixes repeatedly.
   - After import finishes, compute `root_hash` and `version`.
   - Export NodeStore as a RocksDB snapshot tarball with metadata file `manifest.json` containing `version`, `root`, and `checkpoint` H, signature.

4. **Validator acceptance**:
   - Operators validate `manifest.json` and run verification (e.g., recompute a canonical snapshot hash or run independent importer). When N-of-M operators agree on the `root_hash`, accept it.

5. **Rollout**:
   - Distribute snapshot NodeStore to validators and full-nodes.
   - The next produced checkpoint >= H will include `jmt_root` and `jmt_version` marking activation.

Edge Cases:
- Keys added/removed between snapshot export and snapshot acceptance: we fix the canonical H to avoid these problems.
- If NodeStore distribution fails, you can fall back to `incremental replay` (slower).

---

## Snapshot importer tool — spec & APIs

CLI: `sui-jmt-import --input-snapshot=<file> --out-db-dir=<dir> --checkpoint=<H> --version=<start-version>`

Behavior:
- Validates the input snapshot manifest signature
- Replays keys in order and constructs nodes
- Writes nodes to an output RocksDB store
- Creates `manifest.json` containing `{ checkpoint: H, root: 0x..., version: V, created_at, exporter_sig }`

Idempotency: repeat-running with same input must produce the same `root` and `manifest`.

Security: signed manifests to be verified by validators.

---

## RPC & JSON schemas

Add endpoints under `/jmt` for server-side proofs and admin operations.

1) `GET /jmt/proof?key=<hex>&version=<u64>`
Response (JSON): see `ProofResponse` structure in the design.

2) `POST /jmt/proofs/batch` (for batch proof generation)
Request: JSON { "version": u64, "keys": ["0x..", ...] }
Response: stream or array of `ProofResponse`.

3) Admin endpoints (operator-only):
- `POST /jmt/repair?version=<u64>` -> trigger background repair for missing nodes at that version.
- `POST /jmt/import/snapshot` - upload a snapshot manifest to import NodeStore (secured by operator auth).

Rate-limits & quotas should be enforced (e.g., max keys per batch: 1024) to avoid DoS.

---

## CLI tools & operational commands

- `sui-jmt-export-snapshot --db-dir=/var/lib/sui --checkpoint=H --out=snapshot-H.tar.gz`
- `sui-jmt-import --input snapshot-H.tar.gz --out-db-dir=/var/lib/sui-jmt --checkpoint=H`
- `sui-jmt-verify --db-dir=/var/lib/sui-jmt --manifest manifest.json` (verify NodeStore matches manifest)
- `sui-jmt-repair --version V` (scans and re-download missing nodes from peers)

Operator flow example (non-genesis):
1. export snapshot at H
2. run `sui-jmt-import` -> get `manifest.json`
3. distribute `manifest.json` and `snapshot-H.tar.gz` to validator operators
4. consensus: after N-of-M validators verify, enable JMT feature flag for next checkpoint

---

## Concurrency, caching, and perf optimizations

- **Write batching**: group node writes per checkpoint to amortize disk IO.
- **In-memory node cache**: LRU cache for hot internal nodes to speed proof generation.
- **Parallel proof assembly**: for batch proofs, perform per-key proof walk concurrently; share common internal node reads via a request coalescing cache.
- **Prefetching**: when generating a proof, prefetch sibling nodes at expected heights to reduce latency.
- **Write coalescing**: merge duplicate nodes produced in the same checkpoint before persisting.

Memory constraints: cap in-memory mutation structure; if updates too large, stream process using chunked application and intermediate flush to DB.

---

## GC & pruning algorithms

Goal: allow pruning nodes older than `N` versions while guaranteeing proofs for retained versions.

Algorithm A: Reachability-based GC (recommended)

1. Keep a configurable `retain_versions = R` (default 1000)
2. For each epoch, compute roots for the last R versions (we have them persisted). Walk each root to mark reachable nodes using a parallel scanner. Mark nodes as "live" in a temporary mark table.
3. Delete unmarked nodes. Perform compaction in a background job.
4. Update `jmt/meta/last_prunned` to indicate progress.

Complexity: scanning full tree for R roots might be expensive; optimize by incremental marking: only newly unreachable nodes need consideration if retention window shifts by 1.

Refcount approach (alternative): increment/decrement node reference counts, but update overhead may be high.

---

## Testing & property-based specifications

Unit tests:
- Insert a small set of keys; verify root matches expected precomputed values.
- Prove each key and verify inclusion via `verify` function.
- Test non-inclusion cases using neighboring keys.

Property tests (proptest):
- Generate random sequences of operations (inserts/deletes) up to length K (e.g., 1000) and apply sequentially to a reference `Map` and to JMT writer; after each batch, assert that for random keys proof verification returns the same result as the reference map.
- Check history: keep previous roots and ensure `get(key, version)` returns accurate values for historical versions.

Integration tests:
- Mini-cluster that runs 3 validators, produce a sequence of checkpoints with JMT roots, and then query proofs from light client, verifying against checkpoint signatures.

Migration tests:
- Export a snapshot from a running Sui node, run importer, and then verify that importer root equals a manually computed canonical hashed state derived from snapshot.

Fuzz tests:
- Randomly corrupt node bytes and ensure verifier detects invalid proofs without panicking.

CI jobs:
- Run property tests (`cargo test --release`) with proptest shrinking enabled.

---

## Benchmarks & performance targets

Initial target metrics (adjustable):
- Proof generation latency (median): < 50ms for single key on commodity hardware
- Proof generation latency (p95): < 200ms
- Insert throughput (apply_batch, batch size 100): >= 2000 batches/s per node (with RocksDB optimizations)
- Disk overhead: nodes stored should not exceed X% of raw data (requires tuning of hashing and node merging)

Benchmark harness:
- `bench/proof_gen_bench.rs` generating random but realistic key distributions (hot key skew) and benchmarking with and without caches.
- Use `criterion` or Rust `bench` harness to run nightly profiling.

---

## Monitoring & alerts (metrics)

Add Prometheus metrics and alerts:
- `sui_jmt_nodes_written_total` (counter)
- `sui_jmt_proofs_served_total` (counter)
- `sui_jmt_proof_latency_seconds` (histogram)
- `sui_jmt_db_size_bytes` (gauge)
- `sui_jmt_repair_jobs_total` (counter)

Alerts:
- Proof latency p95 > 3x baseline for > 5m
- jmt_db_size growth > 2x day-over-day
- Repair job failure rate > 1% over 1h

---

## Security and auditing

- Review third-party JMT code licenses (Apache-2.0 / MIT are acceptable but verify compatibility with Sui). If reuse is not allowed, implement in-house.
- Fuzz the proof verifier; ensure it handles malformed proofs safely.
- Limit proof request rates and large batch sizes.
- Consider cryptographic audits and bounty for the proof subsystem.

---

## Rollout plan checklist & automation snippets

A step-by-step automation-friendly checklist:

1. Prepare snapshot
   - `sui snapshot export --checkpoint H --out snapshot-H.tar.gz`
2. Import
   - `sui-jmt-import --input snapshot-H.tar.gz --out-db-dir /var/lib/sui-jmt/H --checkpoint H`
3. Validate
   - `sui-jmt-verify --db-dir /var/lib/sui-jmt/H --manifest /var/lib/sui-jmt/H/manifest.json`
4. Distribute
   - Upload the DB tarball to operator storage; provide signed manifest.
5. Enable feature flag on validators
   - Patch config to enable `jmt_enabled=true`, restart validators in a staged manner.
6. Monitor
   - Check metrics for proof latency and DB usage
7. Remove legacy
   - After a safe period, deprecate legacy `state_digest` usage from checkpoint checks.

Rollback plan:
- If something is wrong, disable `jmt_enabled` flag in validators; revert to legacy state digest validation.
- If JMT nodes become corrupted, re-import NodeStore from a known-good snapshot and resume.

---

## Example end-to-end sequence (Genesis)

1. Start chain with empty JMT root (version=0) stored in DB
2. Process transactions, call `apply_batch` each checkpoint
3. Producer writes root to checkpoint; light clients can now request proofs for any published version

## Example end-to-end sequence (Non-Genesis migration)

1. Choose canonical checkpoint `H` where JMT will be activated.
2. Export snapshot at `H` and run `sui-jmt-import` producing `manifest.json` with root `R`.
3. Validators verify `R` and upload NodeStore.
4. At activation checkpoint `H+1`, producers write `jmt_root=R` and `jmt_version=V` into checkpoint summary.
5. Validators accept/checkpoint signed with `jmt_root` enabling clients to request proofs for `V`.

---

## Appendix: Example types & helpers

```rust
/// NodeKey serialization helper
fn node_key(hash: &Hash) -> Vec<u8> {
    let mut k = vec![b'J', b'M', b'T', 0x01];
    k.extend_from_slice(hash);
    k
}
```

---

## Conclusion

This sketch provides a comprehensive engineering-ready blueprint to implement persistent JMT support for Sui, covering low-level storage, serialization, RPCs, migration steps, performance considerations, tests, and monitoring. Next: scaffold `crates/sui-jmt` with the in-memory writer/reader and property tests.
