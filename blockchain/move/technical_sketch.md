Here is a technical sketch for embedding a Jellyfish Merkle Tree (JMT) into the Sui architecture to enable authenticated state commitments.

---

# Technical RFC: Embedding Jellyfish Merkle Tree (JMT) into Sui

## 1. Abstract
This proposal outlines the integration of the **Jellyfish Merkle Tree (JMT)**—a Log-Structured Merge (LSM) tree-optimized sparse Merkle tree—into the Sui validator software stack.

Currently, Sui validates state transitions via quorum signatures on transaction effects and checkpoints. However, it lacks a **Global State Root**, which prevents trust-minimized light client verification, efficient state snapshots for fast sync, and trustless cross-chain bridging. This design proposes an asynchronous state commitment pipeline that generates a cryptographic root of the Global Object Set at every Checkpoint boundary without blocking the parallel execution engine.

## 2. Motivation
* **Light Client Support:** Enabling mobile wallets and embedded devices to verify object states without running a full node.
* **Trustless Bridges:** Allowing foreign chains to verify Sui state proofs (e.g., locking an asset) via a Merkle Root.
* **State Pruning & Archival:** Providing a cryptographically verifiable way to prune old object versions while maintaining a verifiable tip.

## 3. High-Level Architecture

The core design philosophy is **Decoupling**. Sui’s high throughput relies on parallel execution. Inserting a Merkle Tree update into the "hot path" of transaction execution would serialize operations and destroy performance.

Therefore, the JMT embedding will operate on the **Checkpoint** level, not the Transaction level.

### The Pipeline
1.  **Execution Layer (Hot Path):** Validators execute transactions in parallel. State mutations (Object Writes/Deletes) are committed to the localized object store (RocksDB).
2.  **Accumulator (Warm Path):** As a Checkpoint is formed, all state mutations within that checkpoint are gathered into a `StateChangeSet`.
3.  **JMT Updater (Async Path):** The `StateChangeSet` is sorted and applied in a batch to the JMT.
4.  **Commitment:** The resulting Merkle Root is included in the *next* Checkpoint header (or a specialized commitment message) to be signed by the validator set.



---

## 4. Data Structure Design

### 4.1. The Tree Structure (JMT)
The JMT is a binary sparse Merkle tree. Unlike a standard Patricia Trie (Ethereum), the JMT is optimized for storage engines like RocksDB by minimizing disk I/O. It uses variable-length node keys and compresses linear paths in the tree into single "Internal Nodes."

* **Key Space:** 256-bit hash.
* **Node Storage:** Nodes are stored as values in RocksDB, keyed by `(Version, NodeKey)`.

### 4.2. Mapping Sui Objects to JMT
Sui is an object-centric ledger. The JMT must map unique Object identifiers to their contents.

* **Leaf Key ($K$):** The 256-bit hash of the Sui `ObjectID`.
    $$K = \text{Hash}(\text{ObjectID})$$
    *Note: Hashing the ID ensures uniform distribution across the tree, balancing the depth.*
* **Leaf Value ($V$):** The cryptographic digest of the object content (including its version/sequence number and owner).
    $$V = \text{Hash}(\text{ObjectDigest})$$

### 4.3. Handling Object Deletions
When a Sui object is deleted (or wrapped), the corresponding leaf in the JMT must be marked as a null value or removed. JMT supports efficient sub-tree removal if a branch becomes empty.

---

## 5. Integration Workflow

### Phase 1: Batch Accumulation
Sui groups transactions into **Checkpoints** (total ordering). The state commitment will correspond to the state *after* the execution of all transactions in Checkpoint $N$.

Let $S_N$ be the set of all objects modified (created, mutated, deleted) in Checkpoint $N$.
1.  Extract all `(ObjectID, NewObjectState)` pairs from the execution effects.
2.  Compute Leaf Key $K$ and Leaf Value $V$ for each.
3.  Sort the pairs lexicographically by $K$. This is crucial for JMT performance to maximize cache locality during tree updates.

### Phase 2: Asynchronous Tree Update
The JMT resides in a separate Column Family (CF) in RocksDB to avoid contention with the main Object Store.

1.  **Load:** The JMT updater reads the Root Hash of Checkpoint $N-1$.
2.  **Batch Apply:** The updater iterates through the sorted $S_N$. It fetches the necessary internal nodes from RocksDB, re-hashes the path from the leaf up to the root, and generates a new set of "Dirty Nodes."
3.  **Persist:** The "Dirty Nodes" are written to RocksDB.
4.  **New Root:** A new Root Hash $R_N$ is produced.

### Phase 3: Consensus Injection
Because the JMT update takes non-zero time, we cannot include $R_N$ inside Checkpoint $N$ (circular dependency).

* **Lagged Commitment:** The Root Hash $R_N$ (representing the state at Checkpoint $N$) is included as a field in the header of Checkpoint $N+k$ (where $k$ is a small configurable delay, likely 1).
* **Validation:** When validators sign Checkpoint $N+1$, they verify that they computed the same $R_N$.

---

## 6. Storage & Pruning Strategy

One major issue with Merkle Trees in high-throughput chains is "State Bloat." If we store every node of every version of the JMT, storage costs will explode.

### 6.1. JMT Versioning
JMT naturally supports versioning. We can query the state at `Version` (Checkpoint Height). However, we do not need infinite history.

### 6.2. Pruning Policy
We implement a **Sliding Window** commitment strategy.
* **Hot Window:** Keep full JMT node history for the last $X$ epochs (e.g., 2 weeks) to allow for re-orgs (rare in Sui) and proof generation.
* **Cold Storage / Pruning:** A background garbage collector iterates over JMT nodes older than $X$ epochs and deletes them from RocksDB, leaving only the snapshots at specific intervals (e.g., every 10,000 checkpoints) for archival nodes.

---

## 7. Proof Generation (The "Read" Path)



When a light client requests a proof for `ObjectID` at Checkpoint $N$:

1.  The full node locates the Root Hash $R_N$.
2.  It traverses the JMT from Root to the Leaf corresponding to `Hash(ObjectID)`.
3.  It collects the **Siblings** at each level of the tree.
4.  **Response:** The client receives `(ObjectState, [SiblingHashes])`.
5.  **Verification:** The client hashes the object, combines it with siblings, and verifies the result matches the trusted $R_N$.

---

## 8. Summary of Changes Required

| Component | Required Change |
| :--- | :--- |
| **Data Structure** | Import `jellyfish-merkle` crate (likely forked/adapted from Aptos/Diem). |
| **Storage** | Add new RocksDB Column Families: `jmt_nodes`, `jmt_roots`. |
| **Consensus** | Modify `CheckpointHeader` protobuf to include `state_root_hash`. |
| **Executor** | Add a post-execution hook to send `StateChangeSet` to the JMT worker. |
| **RPC** | Add endpoints: `sui_getProof(ObjectID, CheckpointID)`. |

## 9. Next Steps

Would you like me to elaborate on:
1.  **The specific Rust interfaces** needed to connect Sui's `AuthorityState` to the JMT crate?
2.  **The performance benchmarking strategy** to ensure this doesn't degrade Sui's TPS?
3.  **How to handle "stale" reads** during the asynchronous update window?
