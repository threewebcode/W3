This is a critical estimation, as the JMT node storage is the primary source of the Merkle tree's **storage overhead** and **write amplification** within the RocksDB (LSM-tree) database.

Since JMT is a sparse Merkle tree optimized for LSM-trees, the storage increase is not just about the size of one node, but the total number of nodes created over time and the overhead applied by RocksDB's compaction process.

Here is the estimation broken down into the size of an individual JMT node and the resulting total storage increase, assuming standard JMT parameters:

---

##1. 📏 Individual JMT Node Size EstimationThe JMT uses two main types of nodes, and their size is determined by the fixed-size cryptographic digest (hash) used by the system (typically 32 bytes for a 256-bit hash).

###**A. Leaf Node** (Stores the authenticated state entry)The Leaf Node stores the key-value pair you defined, plus the Merkle path.

| Component | Estimated Size (Bytes) | Notes |
| --- | --- | --- |
| **Key** (Node Key) | \approx 40 Bytes | Key is the concatenation of the 32-byte object path (partial hash) and the 8-byte **Version** (Checkpoint Seq. Num.) for LSM-tree optimization. |
| **Object ID** (Internal) | 32 Bytes | The full Object ID. |
| **Object Digest** (Value) | 32 Bytes | The cryptographic hash of the object content. |
| **Overheads** | \approx 20 Bytes | Rust/Serialization overhead, block encoding. |
| **Total Leaf Data** | \approx **124 Bytes** | The raw data of the leaf node entry. |

###**B. Internal Node** (Links the tree structure)The JMT is typically a 16-ary tree (r=16), meaning an Internal Node can have up to 16 children.

| Component | Estimated Size (Bytes) | Notes |
| --- | --- | --- |
| **Key** (Node Key) | \approx 40 Bytes | Same versioned key structure as the Leaf Node. |
| **Pointers/Hashes** | 16 \times 32 \text{ Bytes} | Stores 16 child hashes (digests), one for each path segment. |
| **Bitmap** (Presence) | \approx 4 Bytes | A bitmap indicating which of the 16 children are present (sparse optimization). |
| **Overheads** | \approx 20 Bytes | Rust/Serialization overhead. |
| **Total Internal Node** | \approx **572 Bytes** | The raw data of the internal node entry. |

##2. 📈 Total Storage Increase Estimation (Overhead)The storage increase is measured by the **ratio of JMT nodes created per object**. This is the JMT's **State Amplification Factor**.

The total storage of JMT nodes (S_{JMT}) will be:


Where:

* N_{leaf} = K (Total number of objects/keys, K).
* N_{internal} is the number of internal nodes, which depends on the tree fanout (r=16) and the total number of keys (K).

###**A. JMT Node Count Amplification**In a **perfectly balanced 16-ary tree**, the number of internal nodes (N_{internal}) is related to the number of leaf nodes (K) by:


This means for every **100 Leaf Nodes** (objects), the system must store **\approx 6-7 Internal Nodes**.

###**B. JMT Storage Size Amplification**Using the estimated node sizes:

1. **Storage per 100 Leaves:**
* 100 \text{ Leaves} \times 124 \text{ B/Leaf} = 12,400 \text{ Bytes}
* 6.7 \text{ Internal Nodes} \times 572 \text{ B/Node} \approx 3,832 \text{ Bytes}
* **Total JMT Data (per 100 objects) \approx 16.2 KB**


2. **JMT Data Size Per Object:**



###**C. RocksDB/LSM-Tree Space Amplification**The nature of the JMT, which optimizes for LSM-trees with **version-based keys**, leads to high **Write Amplification (WA)** but predictable **Space Amplification (SA)** compared to B-Trees.

* **Write Amplification (WA):** Since every state update writes a new path of nodes, the WA is high, but the JMT design (versioning + 16-ary fanout) minimizes *compaction* overhead. **This doesn't increase *final* storage, but temporary usage.**
* **Space Amplification (SA):** RocksDB typically has a Space Amplification factor (SA_{RocksDB}) of **1.1 to 1.5** (10% to 50% overhead) *before* counting deleted/stale entries.

###**Final Storage Estimation**The storage overhead for JMT nodes per unique object in the current state is estimated to be:

> \approx \mathbf{162 \text{ Bytes/Object}} \times SA_{RocksDB}

If we assume a typical SA_{RocksDB} of 1.3:


This \approx 210 Bytes must be added to the storage cost of the object's raw data and its key/metadata in RocksDB to get the total storage required for a full node.

---

Would you like to compare this JMT node storage overhead with the storage required for the raw object data itself (which can be 10 \text{ KB} to 1 \text{ MB})?
