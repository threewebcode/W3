# Design: Jellyfish Merkle Tree (JMT) Integration into Sui 🔧🌊

**Status:** Draft — ready for review

## Overview 🎯

This document specifies where, how, and why to integrate a **Jellyfish Merkle Tree (JMT)**-based authenticated key-value state into the Sui codebase. It focuses on integration, migration, API and checkpoint changes, light-client verification, storage, and operational concerns. The document intentionally does not re-specify JMT internal algorithms; it assumes a correct JMT implementation providing persistent, versioned roots and compact inclusion/non-inclusion proofs.

Goals:
- Provide a single authenticated state root per checkpoint (stable, verifiable by validators and light clients).
- Make proofs available via RPC and internal APIs for light clients and other components.
- Support both genesis and non-genesis bootstraps with safe migration strategies.
- Integrate persistently with the existing `sui-kvstore` (or RocksDB-backed stores) while minimizing runtime overhead.

Scope:
- Add a new crate (recommended: `crates/sui-jmt`) implementing the JMT *integration layer* (writer/reader, store adapter, proof API). JMT algorithmic details may be reused from existing implementations if license compatible.
- Modify checkpoint format and checkpoint creation path to record and expose JMT root and version.
- Add RPC / light client endpoints and validate flows for proof issuance & verification.
- Add migration tools and stepwise rollout plan.


---

## Rationale: Why JMT? 💡

- **Compact, verifiable state:** JMT allows compact inclusion/non-inclusion proofs for key-value pairs at a historical version.
- **Versioning:** JMT supports immutable historical roots for snapshots, enabling efficient light-client verification of past state.
- **Proven provenance:** By publishing signed JMT roots in checkpoints, Sui can offer strong guarantees about historical state and produce small trusted proofs to third parties.

Tradeoffs:
- Storage increase due to node persistence; mitigations: node deduplication (by hash), compaction and GC policies.
- Complexity to migrate existing state (non-genesis); mitigations: offline snapshot import, phased rollout.


---

## High-Level Architecture 🏗️

Components to add/modify:

- `crates/sui-jmt` (new): integration crate exposing the public API for JMT operations + NodeStore adapter and proof serialization compatible with Sui types.
- NodeStore adapter: a thin layer mapping JMT nodes to Sui persistent storage (likely `sui-kvstore` / RocksDB). Keys are namespaced to avoid collisions (prefix `jmt/node/` etc.).
- Checkpoint metadata: extend checkpoint objects with `jmt_root: Hash` and `jmt_version: u64` (or `Option` until enabled).
- Checkpoint flow change: when validators finalize a checkpoint, the state-change producer must produce the JMT root and record it in the checkpoint
- RPC endpoints: add APIs for proof requests (e.g., `prove_state(key, version) -> Proof`) and aggregated proof queries.
- Light client verifier: a client-side verification flow that verifies proofs vs `jmt_root` included in a signed checkpoint.

Data flow (at a glance):
1. Transaction execution produces state diffs.
2. Execution writes updates to the underlying key-value store, but also passes update batch to JMT writer.
3. JMT writer applies updates, persists any new nodes to NodeStore, returns a new `jmt_root` and `version`.
4. On checkpoint commit, the `jmt_root` and `version` are packaged into `Checkpoint` metadata and signed as usual.
5. Nodes can serve proofs for any `version` by traversing NodeStore and returning the compact `Proof` to a client.


---

## Design details ✍️

### Crate design: `crates/sui-jmt`

Responsibilities:
- Expose a storage-agnostic `JmtWriter` and `JmtReader` API.
- Provide `NodeStore` trait for persistent storage integration.
- Provide `Proof` type, serialization methods, and verifier helpers.

Suggested public API (sketch):

```rust
// crate: sui-jmt
pub struct JmtWriter<S: NodeStore, H: HashAlgo> { /* ... */ }
pub struct JmtReader<S: NodeStore, H: HashAlgo> { /* ... */ }

impl<S: NodeStore, H: HashAlgo> JmtWriter<S, H> {
    pub fn apply_batch(&mut self, updates: &[Update]) -> Result<Version, Error> { /* commit and return new version */ }
    pub fn root(&self, version: Version) -> Result<Hash, Error> { /* latest or historical root */ }
}

impl<S: NodeStore, H: HashAlgo> JmtReader<S, H> {
    pub fn get(&self, key: &Key, version: Version) -> Result<Option<Value>, Error>;
    pub fn prove(&self, key: &Key, version: Version) -> Result<Proof, Error>;
}
```

`NodeStore` trait should be implemented by adapters to `sui-kvstore` / RocksDB.

Storage layout:
- Keys: `b"jmt/node/" || node_hash` -> serialized node bytes
- Roots: `b"jmt/root/" || version` -> root hash value
- Optional: `b"jmt/metadata/latest_version"` storing current version number

Note: Node deduplication is handled by node hash: store nodes indexed by hash only.

### Checkpoint metadata changes

Current model: `Checkpoint` contains `state_digest` (or similar). We'll replace/extend with JMT metadata.

Add fields to the checkpoint struct (Rust sketch):

```rust
struct CheckpointSummary {
    // existing fields...
    pub jmt_root: Option<Hash>,        // None until JMT is enabled for that epoch
    pub jmt_version: Option<u64>,      // persistent version number
}
```

Semantics:
- `jmt_root` is the authenticated root of the state after applying the checkpoint's transactions.
- `jmt_version` is the internal JMT version corresponding to the root (monotonic counter).
- Validators include `jmt_root` as part of their signed checkpoint summary; thus it is covered by the consensus signatures.

Why Optional? During phased rollout `jmt_root` may be absent on older or mixed nodes.

Backwards-compatibility: Nodes not understanding JMT treat `jmt_root: None` as legacy operation; light clients must require JMT-enabled checkpoints to request proofs.

### Checkpoint production & transaction execution changes

At the end of each checkpoint's transaction execution phase (the component that already collects state writes):
1. Collect the set of state updates (key->value modifications / deletions) performed by transactions included in the checkpoint.
2. Pass this update batch to `JmtWriter::apply_batch()` which returns the new `jmt_root` and `jmt_version`.
3. Persist the `jmt_root` and `jmt_version` in the checkpoint summary and write any newly created nodes into `NodeStore` atomically with the underlying DB transaction if supported.
4. If atomicity across the two storage layers cannot be ensured, write metadata to ensure eventual consistency (see 'Atomicity & crash consistency' below).

Notes on atomicity and durability:
- Best: perform checkpoint DB write and JMT node writes under the same RocksDB transaction or same `sui-kvstore` transaction (if underlying supports transactions). This ensures `root` is durable only when nodes are persisted.
- Fallback: use two-phase commit via a write-ahead flag (e.g., `jmt/txn/<checkpoint>` -> (staged nodes)); then commit atomically and mark completion. A background compaction can finalize.

### Genesis start vs Non-Genesis start (migration) 🔁

Two distinct bootstrap scenarios must be supported.

1) **Genesis start** (new chain or fresh network):
   - At genesis, create an empty JMT root (or the root derived from genesis state) and include `jmt_root` in genesis checkpoint.
   - Optionally bootstrap by replaying genesis state into JMT writer; because all nodes start from the same genesis, no migration is needed.

2) **Non-Genesis start (migrating an existing network)**: This is the complex case.

Approach A — Snapshot importer (recommended):
- Choose a target checkpoint height `H` to bootstrap JMT.
- Export a deterministic snapshot of the state at `H` (all key-value pairs) from the current `sui-kvstore`.
- Run an offline snapshot import tool (e.g., `sui-jmt-import`) that iterates sorted key list, builds JMT nodes, and writes them to a NodeStore, producing a computed `jmt_root` and `jmt_version`.
- Validate the computed `jmt_root` agrees with a hashed state canonicalization (e.g., hash of exported snapshot if agreed by operators).
- Publish `jmt_root` in a special checkpoint or schedule a manifest announcing `jmt_root` at version `H`.

Approach B — Incremental replay (alternative):
- Replay all historical transactions from genesis up to `H` applying updates to an in-memory JMT writer and persist nodes periodically. This approach is slower and requires full transaction histories.

Important: export/import must guarantee deterministic ordering of keys and updates to ensure all nodes compute the same root.

Rolling migration strategy:
- Prefer to deploy the snapshot importer, distribute produced NodeStore to validators (or a trusted importer), then enable JMT at agreed checkpoint.
- Nodes not yet updated will ignore `jmt_root` field until they are upgraded.

### Light clients: Proof issuance & verification 🔐

Flow for light clients (general flow):
1. Light client receives a signed checkpoint summary `C` from validators (or reads via RPC) which contains `jmt_root` and `jmt_version`.
2. Client requests proof `P` from a full node: `prove_state(key, version=jmt_version)`.
3. Full node loads nodes necessary to serve proof `P` from NodeStore and returns `P` serialized along with `value_opt` and `root` metadata.
4. Light client locally verifies `verify(root, key, value_opt, P)` against `C.jmt_root`. If verification passes and `C` is signed by quorum, the client trusts the state.

RPC semantics & schemas (examples):
- RPC: `GET /jmt/proof?key=<hex>&version=<u64>` -> returns `ProofResponse { root, version, proof_bytes, value_opt }`.

Security notes:
- Clients MUST only accept proofs paired with a `jmt_root` that is included in a checkpoint that has sufficient validator signatures.
- Full nodes must rate-limit expensive proof requests and provide streaming proofs for very large requests.

### Proof storage & issuance: tradeoffs

Options:
- On-demand generation: compute proof from NodeStore for requested key/version (lower storage but CPU cost to walk nodes). Recommended for initial rollout.
- Precomputed proofs: store per-key proofs at each checkpoint (very expensive in storage). Not recommended.

### Non-inclusion proofs

Ensure `prove_state` returns a proof for non-inclusion if the key is absent at the given `version`. This is essential for correctness when proving non-existence.


---

## Operational and Storage Concerns 🧰

### Node persistence naming scheme (suggested)

- Node key: `jmt/node/<hash>` -> node bytes
- Root key: `jmt/root/<version>` -> root bytes + metadata (timestamp, checkpoint_id)
- Version index: `jmt/version/latest` -> u64

### Pruning & GC

- Keep nodes referenced by `N` latest versions (configurable) and prune nodes exclusively referenced by older versions.
- Optionally implement refcounting or reachability-tracing compaction: walk from stored roots for the last `N` versions and compact nodes not reachable.

### Concurrency & performance

- Batch writes into a RocksDB transaction for each checkpoint when possible.
- Use write buffers and batching in `JmtWriter` to reduce IO overhead.
- Cache frequently used internal nodes to speed up proof generation.

### Failure modes

- Node writes succeed but checkpoint write fails: need a recovery mechanism to roll back or resume commit (two-phase commit via `jmt/staging` flags is recommended).
- NodeStore corruption: add checksums and vulnerabilities monitoring; provide a rebuild path (recompute from snapshot/transactions).

### Metrics & Monitoring 📊

Add metrics such as:
- `jmt_nodes_written_total`
- `jmt_proofs_served_total`
- `jmt_proof_generation_duration_seconds`
- `jmt_root_commits_total`
- `jmt_node_db_size_bytes`

Add monitoring alerts for:
- Sudden spike in node DB size
- Excessive proof latency or timeouts
- Root commit failures


---

## Compatibility & Rollout Plan 🚦

Phased rollout recommended.

1. **Design & prototype** (local): implement `crates/sui-jmt` and an in-memory prototype with unit tests and property tests.
2. **Non-consensus experimental net**: integrate into a testnet where all nodes run JMT-capable code; enable `jmt_root` in checkpoints but optional.
3. **Snapshot bootstrap release**: publish tooling to compute snapshot importer; run migration to generate NodeStore for chosen non-genesis networks.
4. **Feature flag**: add a runtime flag controlling JMT activation per node (and per checkpoint). The feature is enabled by validators in a coordinated upgrade.
5. **Mainnet gradual activation**: enable JMT for a checkpoint only after validating snapshot importers and tooling. Only accept proofs when `jmt_root` is present in signed checkpoint summary.
6. **Fully mandatory**: deprecate the legacy `state_digest` field and make JMT roots required in all checkpoints (long-term goal).

Notes on safety: validators must reach consensus on the chosen `jmt_root` upon activation. Node operator coordination is essential for snapshot importer / migration.


---

## Testing Strategy ✅

- **Unit tests:** verify writer/reader correctness, serialization, and simple inclusion/non-inclusion proofs.
- **Property tests:** fuzz random sequences of updates, check that generate & verify proofs hold for all versions.
- **Integration tests:** bring up mini-cluster, execute transactions that mutate state, finalize checkpoints, fetch proofs and verify.
- **Migration tests:** run snapshot import on a known dataset and verify the computed root and that the full nodes can serve proofs.
- **Performance tests:** measure throughput for writes per second, proof generation time, proof sizes and storage growth.

Add CI jobs to run property tests and a small-scale integration test.


---

## Security & Review 🔐

- Perform a security review of any third-party JMT code used.
- Ensure proof verifier is deterministic and robust to malformed proofs (do not panic; return structured errors).
- Review storage access controls to ensure nodes cannot leak proofs of private state (if privacy concerns are relevant in Sui context).


---

## Migration checklist for Non-Genesis Bootstrapping ✅

- [ ] Implement the snapshot exporter (secure deterministic sorted export of all key/value pairs at checkpoint `H`).
- [ ] Implement `sui-jmt-import` that outputs NodeStore data and a signed manifest containing `jmt_root` and `H`.
- [ ] Validators/operators validate the importer output and mark the `jmt_root` as canonical for checkpoint `H`.
- [ ] Release a coordinator script and operational docs describing how to publish the NodeStore to validators.
- [ ] Add a validation check in nodes to ensure they can serve proofs for `H` once enabled.


---

## Open Questions / Design Decisions to make ❓

- Hash algorithm choice: should we adopt Sui's canonical hash (if one exists) or use a pluggable algorithm with default to blake2b/sha256? (Recommendation: use existing Sui hash for compatibility.)
- Atomic commit model: can the existing `sui-kvstore` provide transactional semantics for JMT node writes? If not, implement staging/commit flags.
- GC policies: what is the retention window (N latest versions) appropriate for Sui? (Recommendation: start with configurable N=1000 and tune.)
- Proof bandwidth & rate limiting: what quotas to enforce for public RPC endpoints?


---

## Implementation roadmap (concrete next steps) 🛣️

1. **Design finalization & approval** — converge on field names (`jmt_root`/`jmt_version`) and storage layout.
2. **Prototype** — create `crates/sui-jmt` with an in-memory writer/reader and unit tests (verify property tests locally).
3. **NodeStore adapter** — implement `NodeStore` backed by `sui-kvstore`/RocksDB.
4. **Checkpoint integration** — wire `JmtWriter::apply_batch()` into the checkpoint commit path and persist root & nodes atomically.
5. **RPC and light-client endpoints** — add `GET /jmt/proof` and client verification examples.
6. **Snapshot importer** — build `sui-jmt-import` tool for non-genesis bootstrapping.
7. **Integration testing and small-scale testnet** — validate correctness and performance.
8. **Performance tuning** — node caching, batching, pruning.
9. **Mainnet rollout** — follow phased plan with operator coordination.

---

## Appendix: Example checkpointer change (pseudo)

```rust
// Before
struct CheckpointSummary {
    state_digest: Hash,
    // ...
}

// After
struct CheckpointSummary {
    state_digest: Hash, // legacy-compatible; may be deprecated
    jmt_root: Option<Hash>,
    jmt_version: Option<u64>,
    // ...
}
```

When producing a checkpoint, the producer would do:
1. let updates = collect_state_updates();
2. let jmt_version = jmt_writer.apply_batch(&updates);
3. let jmt_root = jmt_writer.root(jmt_version);
4. checkpoint_summary.jmt_root = Some(jmt_root);
5. persist checkpoint atomically with nodes (or via staging if needed).


---

## Conclusion ✅

This spec outlines the integration approach and tradeoffs for adopting JMT in Sui. The next immediate step is to implement a minimal in-memory prototype crate (`crates/sui-jmt`) and a snapshot import utility for non-genesis migration. After verification on testnets, we can plan the mainnet rollout under a feature-flagged, phased activation.

*Document authored by GitHub Copilot*
