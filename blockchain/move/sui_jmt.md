---

## 1️⃣ First Principles: What JMT Is *For* in Sui

JMT should **not** be treated as:

* a runtime dependency for transaction execution
* a replacement for Sui’s object-based parallelism

Instead, JMT is used as:

> **A cryptographic commitment to finalized state for verification, light clients, and ZK proofs**

This is similar to how Aptos uses JMT, but adapted to Sui’s object model.

---

## 2️⃣ What Exactly Goes Into the JMT?

### Key Design Choice

The JMT should commit to **objects**, not accounts.

**Key**:

```
hash(object_id || version)
```

**Value**:

```
hash(object_contents || owner || metadata)
```

This preserves:

* multi-version concurrency
* object immutability
* parallel execution

> 🔑 Each object version is a leaf, not mutable storage.

---

## 3️⃣ When Is the JMT Updated?

### ❌ Not during execution

### ✅ During finalization / checkpointing

Sui already has **checkpoints and epochs** — this is where JMT fits cleanly.

### Flow:

1. Validators execute transactions using object DAG
2. Transactions are finalized into a checkpoint
3. **Checkpoint builder updates the JMT**
4. New **JMT root hash** is emitted with the checkpoint

This keeps execution fast and parallel.

---

## 4️⃣ Validator Responsibilities

Each validator maintains:

* Full object store (already exists)
* JMT node store (new)

### Update algorithm per checkpoint:

```
for each mutated object:
    delete old (object_id, old_version)
    insert new (object_id, new_version)
```

Because JMT is **sparse and versioned**, updates are efficient.

---

## 5️⃣ What Guarantees Does JMT Provide?

Once embedded, JMT enables:

### ✅ State inclusion proofs

> “This object existed at checkpoint N”

### ✅ Non-existence proofs

> “This object did not exist at checkpoint N”

### ✅ ZK-friendly commitments

> zkVMs can verify object membership without trusting validators

### ✅ Light clients

> No need to download full state

---

## 6️⃣ How ZKVM Uses JMT (Important)

The ZKVM **does NOT execute over JMT**.

Instead:

1. ZKVM executes the transaction logic
2. ZK circuit verifies:

   * object inputs
   * execution trace
3. **Merkle proofs are only used at the boundary**

   * inputs exist under JMT root
   * outputs are committed to next JMT root

This separation is critical.

### ZK Statement Example:

```
Given:
  - JMT_root_before
  - Merkle proofs for input objects
  - execution trace
Prove:
  - execution is valid
  - new objects commit to JMT_root_after
```

---

## 7️⃣ Why JMT (Specifically) Works Well for Sui

JMT advantages that match Sui:

| JMT Property         | Why It Fits Sui               |
| -------------------- | ----------------------------- |
| Sparse               | Object IDs are large hashes   |
| Versioned            | Objects are versioned         |
| Efficient updates    | Few objects mutate per tx     |
| Non-existence proofs | Important for object creation |
| ZK-friendly          | Hash-based, deterministic     |

---

## 8️⃣ Network-Level Integration Plan (Step-by-Step)

### Phase 1: Passive Commitment

* Build JMT at checkpoints
* Expose root via RPC
* No consensus dependency

### Phase 2: Proof APIs

* Add object inclusion / exclusion proofs
* Light client support

### Phase 3: Consensus Binding

* Validators sign checkpoint + JMT root
* Root becomes consensus-critical

### Phase 4: ZK Integration

* ZKVM accepts JMT roots
* Enable trust-minimized verification

---

## 9️⃣ What This Does *NOT* Change

❌ Transaction execution model
❌ Object ownership rules
❌ Parallelism
❌ Gas semantics

JMT is **purely a cryptographic commitment layer**.

---

## 10️⃣ Mental Model (Very Important)

Think of Sui as:

```
Execution Layer   → Object DAG (fast, parallel)
Commitment Layer  → JMT (cryptographic truth)
Proof Layer       → ZKVM / Light Clients
```

Each layer is cleanly separated.

---

## 🔑 Final Takeaway

> **Embedding JMT into Sui is about committing to state, not executing state.**

By:

* committing object versions at checkpoints
* using JMT only at verification boundaries
* keeping execution object-centric

Sui can gain **ZK proofs, light clients, and cross-chain verification** without sacrificing its core performance model.
