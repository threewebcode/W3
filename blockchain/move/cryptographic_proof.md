Below I’ve collected and organized the main cryptographic commitment schemes, authenticated data structures, and proof systems that are (or have been) used in blockchain systems. For each entry you’ll find: what it is / why it’s used, a short technical sketch, important properties (hiding/binding, succinctness, trusted-setup, post-quantum), typical blockchain use-cases, and brief notes on trade-offs and representative projects or libraries. If you want, I can export this as a single Markdown file, spreadsheet, or a GitHub gist.

Summary categories
- Commitment schemes and hash-locks (simple commitments)
- Merkle-like authenticated data structures and accumulators (membership/inclusion proofs)
- Pedersen / ElGamal / vector / polynomial commitments
- Range proofs & confidential-transaction proofs
- Signature-based proofs and Sigma protocols (proofs-of-knowledge)
- Non-interactive succinct zero-knowledge proofs (zk-SNARKs, Groth variants)
- Transparent/STARK-style proofs (zk-STARKs)
- Succinct transparent proofs and recursive proof systems (Halo, PLONK variants)
- Other privacy/soundness primitives used in blockchain (ring signatures, accumulators, HTLCs)
- Practical trade-offs and guidance

1) Basic commitment primitives
- Hash commitment (hashlock)
  - Purpose: Commit to a secret via H(x) so you can reveal x later; used as a simple binding+opaque commitment.
  - Sketch: Commit = H(secret || optional randomness).
  - Properties: Binding under collision/preimage hardness of H; usually not hiding unless randomness included; trivial, efficient.
  - Use-cases: HTLCs (atomic swaps, Lightning Network), hash-based state commitments, simple on-chain commitments.
  - Trade-offs: Simple but no advanced algebraic properties (no homomorphism).

- Pedersen commitment
  - Purpose: Information-theoretically hiding, computationally binding (under discrete log). Widely used where homomorphic commitments are required.
  - Sketch: C = g^r * h^m in a group of prime order (g,h independent), r random.
  - Properties: Perfectly hiding, binding under DL assumption, additive homomorphism (C(m1) * C(m2) = C(m1+m2)).
  - Use-cases: Confidential Transactions (Bitcoin Elements/Liquid), Monero (RingCT uses Pedersen), multi-party protocols, range proofs.
  - Trade-offs: Requires group setup and secure generator choices; fits well with elliptic-curve cryptography.

- ElGamal / homomorphic commitments
  - Purpose: Commitment and encryption style schemes with homomorphic properties.
  - Use-cases: Various multiparty protocols, mixers, some layer-2 constructions.

2) Authenticated data structures & accumulators (membership proofs)
- Merkle Tree
  - Purpose: Efficient authenticated membership/inclusion proofs for sets of items.
  - Sketch: Binary (or k-ary) tree over leaves: each internal node = H(child1 || child2). Proof = sibling hashes along path.
  - Properties: Logarithmic-sized inclusion proofs, simple, no trusted setup, based on hash security.
  - Use-cases: Bitcoin transaction Merkle root in block header, light client SPV proofs, many blockchains’ transaction/state commitments.
  - Trade-offs: Proofs grow with tree depth; update costs; requires storing path or ability to recompute.

- Merkle Patricia Trie (MPT) / Patricia Tries / Sparse Merkle Tree (SMT)
  - Purpose: Key-value authenticated map with compact root representing state (Ethereum uses MPT).
  - Sketch: Trie of keys; nodes authenticated by hashes; SMT uses implicit empty branches for fixed keyspace.
  - Properties: Efficient per-key proofs, suitable for dynamic state, hash-based (no setup).
  - Use-cases: Ethereum state/store, proofs for accounts/balances; stateless client designs.
  - Trade-offs: Complexity; canonicalization rules matter (RLP/serialization).

- Merkle Mountain Range (MMR)
  - Purpose: Append-only authenticated structure supporting compact proofs for historic inclusion (useful for light clients).
  - Use-cases: UTXO set history, Bitcoin SPV improvements, block history proofs.

- Verkle tree (vector commitments using polynomial commitments, e.g., KZG)
  - Purpose: Reduce proof sizes and verification complexity for key-value stores compared to Merkle tries; smaller proofs (amortized constant-size) via vector/polynomial commitments.
  - Sketch: Leaves are vectors; a polynomial commitment (e.g., KZG) authenticates the vector; proofs are polynomial evaluation proofs.
  - Properties: Much smaller proof sizes vs Merkle, but typically rely on KZG-style polynomial commitments which require a trusted setup (single-ceremony toxic waste).
  - Use-cases: Proposed for Ethereum state (Verkle tree proposals), stateless clients, scalability.
  - Trade-offs: Trust/setup assumptions (KZG), but great for compact state proofs.

- RSA accumulator
  - Purpose: Constant-size membership witnesses for a set (and sometimes membership/non-membership with extensions).
  - Sketch: Acc = g^{\prod p_i} mod N (with primes p_i representing elements); witness roughly g^{\prod_{j≠i} p_j}.
  - Properties: Very small accumulators/witnesses but operations require heavy modular exponentiation; trusted modulus generation (or strong RSA assumptions).
  - Use-cases: Some identity/credential systems, UTXO set accumulators, light clients.
  - Trade-offs: Expensive ops, special setup assumptions.

3) Polynomial and vector commitments (used in zk and state commitments)
- KZG (Kate–Zaverucha–Goldberg) polynomial commitment
  - Purpose: Commit to a polynomial; produce succinct evaluation proofs at points (constant-size proof).
  - Sketch: Commit = g^{poly(τ)} with trusted trapdoor τ (powers-of-τ SRS). Proof uses quotient polynomial and pairing checks.
  - Properties: Very small constant-size proofs and fast verification with pairings; requires trusted setup (SRS) and trapdoor secrecy.
  - Use-cases: PLONK-like SNARKs, Verkle trees, Ethereum rollup/data-availability designs (EIP proposals), polynomial commitments in many ZK systems.
  - Trade-offs: Trusted setup; relies on pairing-friendly curves and a ceremony.

- Other polynomial commitments (e.g., bulletproof inner-product commitments, Kate vs IPA variants)
  - Purpose: Avoid trusted setup (e.g., inner-product argument-based commitments used in Bulletproofs or Halo).
  - Trade-offs: Larger proofs or slightly different performance characteristics; no SRS/trusted setup in some approaches.

4) Range proofs & Confidential Transactions
- Range proofs in Confidential Transactions
  - Purpose: Prove that a committed value lies in a valid range (non-negative and < 2^n) without revealing the value — prevents overflow/creation of money.
  - Techniques: Bulletproofs (modern), earlier: Borromean ring signatures, older: multiple commitments + zero-knowledge proofs.
  - Properties: Bulletproofs are non-interactive, no trusted setup, logarithmic-sized proofs; used to make CT practical on-chain.
  - Use-cases: Confidential Transactions (Elements/Liquid), Monero’s RingCT (range proofs for outputs).
  - Trade-offs: Prover cost can be high (but much improved vs older schemes); proofs are larger than Groth16 SNARKs but require no trusted setup.

5) Signature schemes and Sigma-protocols / proofs-of-knowledge
- Schnorr signatures & Schnorr-based proofs-of-knowledge
  - Purpose: Signature and discrete-log proofs-of-knowledge; amenable to multi-signature aggregation (MuSig) and non-interactive ZK via Fiat–Shamir.
  - Sketch: Interactive Sigma protocol for discrete log turned non-interactive by Fiat–Shamir gives a NIZK proof of knowledge of private key.
  - Use-cases: Bitcoin Taproot/Taproot scripts use Schnorr; MuSig for multi-sig aggregation; signature-based commitment to control outputs.
  - Trade-offs: Security in random-oracle model for Fiat–Shamir transform; schemes are not post-quantum.

- Sigma-protocols (general 3-move interactive proofs)
  - Purpose: Standard building block for constructing zero-knowledge proofs of knowledge (e.g., show knowledge of discrete log or representation).
  - Use-cases: Many ZK constructions are built from Sigma protocols, transformed to non-interactive proofs by Fiat–Shamir.

6) SNARKs — succinct non-interactive arguments of knowledge (trusted-setup families)
- zk-SNARK (Groth16 and variants)
  - Purpose: Very small proofs, extremely fast verification, widely used for private transactions and rollups.
  - Sketch: QAP/R1CS-based proving with SRS/trusted setup; Groth16 yields ~tiny proof (3 group elements + one scalar).
  - Properties: Very succinct proofs and very fast verification; requires a trusted setup (per-circuit SRS) for many constructions (though some universal setups exist).
  - Use-cases: Zcash (Zcash Sapling → earlier Groth16), many early zk-rollups, private coins.
  - Trade-offs: Trusted setup complexity (though universal/powers-of-tau helps), limited post-quantum security (relies on pairing-friendly curves).

- PLONK-like universal SNARKs (PLONK, Sonic, Marlin)
  - Purpose: Universal and updatable trusted setup for many circuits; aim to reduce ceremony complexity.
  - Properties: Universal SRS so you can reuse setup across many circuits; proof sizes small, verification efficient.
  - Use-cases: Modern zk-rollups and general-purpose zk compilers (e.g., zkSync, StarkNet layer constructs often use PLONK variants).
  - Trade-offs: Still requires a one-time SRS (but updatable), pairing-based primitives.

7) STARKs — transparent scalability proofs
- zk-STARK
  - Purpose: Transparent (no trusted setup) STARKs provide succinct, post-quantum secure proofs for arbitrary computation using FRI and IOPs.
  - Sketch: Build an algebraic representation of computation as low-degree polynomials and use low-degree testing + FRI for integrity; leverage randomness via public coins.
  - Properties: No trusted setup, post-quantum secure (information-theoretic assumptions + hash functions), transparent, but proof sizes and verification time larger than Groth16 SNARKs (though much improved engineering mitigates this).
  - Use-cases: StarkWare products (Cairo/STARK-based rollups), large computation proofs and some DA proofs.
  - Trade-offs: Larger proof sizes, heavier prover cost historically; great transparency & post-quantum resistance.

8) Recursive & transparent succinct recursion (Halo family, PLONK recursion)
- Halo / Halo2
  - Purpose: Recursive proof composition without a trusted setup (Halo uses IVC-style recursion via inner-product argument).
  - Sketch: Use commitment + inner-product arguments; recursion allows proving that many prior proofs are valid via succinct proofs-of-proofs (proof composition).
  - Properties: No trusted setup (Halo variants), supports recursive proofs for scalability and compressed verification.
  - Use-cases: Ethereum/zk-rollup recursive aggregation, Zcash research (Halo2), systems implementing recursive validity proofs.
  - Trade-offs: Complexity of implementation; trade-offs in prover/verifier performance.

9) Bulletproofs (inner-product arguments)
- Bulletproofs
  - Purpose: Short, non-interactive range proofs without trusted setup; applicable to many arithmetic statements (via generalization).
  - Sketch: Inner-product argument yields proof size logarithmic in range; single-prover, non-interactive via Fiat–Shamir.
  - Properties: No trusted setup; proof size = O(log n) group elements; verification heavier than SNARKs but reasonable.
  - Use-cases: Monero (earlier versions used Borromean, later switched to Bulletproofs for range proofs), Confidential Transactions.
  - Trade-offs: Proofs bigger than SNARKs, but simpler trust model.

10) Aggregation, recursive composition, and succinctness techniques
- Aggregated signatures and MuSig
  - Purpose: Aggregate multiple signatures into one, reduce on-chain footprint.
  - Use-cases: Schnorr-based aggregation in Bitcoin Taproot proposals; multi-sig schemes.
- Recursive SNARKs
  - Purpose: Aggregate many proofs on-chain by producing a single succinct proof that attests to many computations (used by recursive zk-rollups).
  - Use-cases: Some rollups implement recursion to collapse batch proofs into one light verification.

11) Ring signatures, linkable ring signatures, and mix-based privacy schemes
- Ring signatures (CryptoNote / Monero)
  - Purpose: Signer ambiguity — a signature that proves one of a set signed without revealing which one.
  - Use-cases: Monero transaction input privacy; RingCT combined ring signatures with Pedersen commitments & range proofs.
  - Properties: Linkable variants prevent double spending; size and verification costs vary; newer designs reduce proof sizes (CLSAG).
  - Trade-offs: Scalability vs privacy; verifier cost increases with ring size.

12) Accumulators and non-membership proofs
- Merkle accumulators, RSA accumulators, polynomial commitment-based accumulators
  - Purpose: Small proofs for (non-)membership, used to compress UTXO sets or state.
  - Use-cases: Stateless clients proposals, UTXO commitments, revocation lists.
  - Trade-offs: Choice of accumulator affects proof size, update cost, and trust assumptions.

13) Fraud proofs vs validity proofs (optimistic vs validity-based L2s)
- Fraud proofs (optimistic rollups)
  - Purpose: Submit execution batches optimistically; if fraud is suspected, a fraud proof (interactive or compressed) is submitted to challenge an invalid state transition.
  - Techniques: Interactive verification games, partial re-execution, bisection protocols to pinpoint error.
  - Use-cases: Optimistic rollups (Optimism, Arbitrum).
  - Trade-offs: Liveness and challenge window requirements; appeals to finality delays.

- Validity proofs (zk-rollups)
  - Purpose: Submit cryptographic proof that the batch is valid (e.g., SNARK/STARK).
  - Use-cases: zk-rollups (zkSync, StarkNet variants).
  - Trade-offs: Complexity of proof generation vs immediate finality and much stronger correctness guarantees.

14) Data Availability proofs and sampling
- Erasure coding, data availability sampling (DAS)
  - Purpose: Ensure that block data is posted and available off-chain; light clients randomly sample pieces to check availability.
  - Techniques are often combined with polynomial commitments (KZG) for efficient DA sampling.
  - Use-cases: Rollups, sharding designs (Ethereum sharding research).
  - Trade-offs: Protocol complexity; reliance on polynomial commitments in some proposals (trusted SRS).

15) Practical libraries, frameworks, and example projects (representative — not exhaustive)
- libsnark, bellman, arkworks-rs — SNARK libraries
- snarkjs, circom — circuit compiler & JS proving toolchain
- Bulletproofs implementations: dalek-cryptography/bulletproofs (Rust)
- Halo2 — Electric Coin Co’s Halo2 (Rust)
- Winterfell — STARK implementation (Rust)
- StarkWare — Cairo + STARK stack
- Zcash — sapling, Halo2 work; Zcash originally used Groth16
- Monero — RingCT, CLSAG, Bulletproofs for range proofs
- Ethereum clients / EIPs — MPT, proposals for Verkle trees, KZG for data availability

16) Properties comparison (high level)
- SNARKs (Groth16)
  - Proof size: very small (~constant)
  - Verifier cost: very low
  - Prover cost: moderate-high
  - Trusted setup: yes (per-circuit), or universal SRS (less ideal)
  - Post-quantum: no
- PLONK-like SNARKs
  - Proof size: small
  - Trusted setup: universal/updatable
- STARKs
  - Proof size: larger than SNARKs, but improving
  - Verifier cost: higher than SNARKs but still sublinear
  - Trusted setup: none (transparent)
  - Post-quantum: yes (relies on hashes)
- Bulletproofs
  - Proof size: O(log n)
  - Trusted setup: none
  - Use-case: range proofs, confidential amounts
- Pedersen commitments
  - Trusted setup: no (but group parameter choice matters)
  - Use-case: privacy, homomorphic commitments

17) Trust models and security assumptions to watch
- Trusted setup (KZG, Groth16): single- or multi-party ceremony; toxic waste compromise breaks soundness.
- Pairing-friendly curves: used in many SNARKs; rely on elliptic-curve assumptions (not post-quantum).
- Transparent proofs (STARKs, Bulletproofs): rely mainly on hash functions/standard assumptions; more post-quantum resilient.
- Fiat–Shamir transform: turns interactive Sigma protocols into non-interactive proofs in the Random Oracle Model — security relies on modeling hash as random oracle.

18) Practical guidance: which to choose for common needs
- Compact on-chain verification of arbitrary computation (rollups): use SNARKs (PLONK/PLONK variants) or STARKs depending on trust model vs proof size preferences. For zero trusted setup need, use STARKs or Halo-style transparent recursion.
- Confidential transactions / privacy for values: Pedersen commitments + range proofs (Bulletproofs for no-setup; SNARK range proofs if you accept setup and want tiny verification).
- Lightweight inclusion proofs for clients: Merkle / Sparse Merkle / Verkle (if short proofs and trade SRS) depending on desired proof size and trust assumptions.
- Stateless clients: Verkle trees (with KZG) or other vector commitments for small proofs, but account for SRS/trusted setup.
- Atomic swaps, channels: Hash commitments (HTLC), signature-based spending conditions, timelocks.

19) Important research & background reading (core topics/papers — recommended)
- Merkle trees (Merkle authentication)
- Pedersen commitments (homomorphic commitments)
- Fiat–Shamir transform and Sigma-protocol literature
- Groth16 (and QAP/R1CS-based SNARK literature)
- PLONK, Sonic, Marlin (universal SNARKs research)
- zk-STARK papers (Ben-Sasson et al.)
- Bulletproofs paper (Bünz et al.)
- KZG polynomial commitment paper (Kate, Zaverucha, Goldberg)
- Papers on accumulators (RSA accumulators, dynamic accumulators)
- RingCT / Monero privacy papers

20) Next steps I can do for you
- Produce a detailed Markdown document (with references and links) collecting the above plus canonical paper citations and implementation links.
- Generate a comparison table (CSV/Markdown) that includes proof size, prover/verifier complexity, trusted-setup, applications, and recommended libraries.
- Dive deeper into any one family (e.g., design & implementation details of KZG/Verkle, or how zk-rollups pick SNARK vs STARK), including code examples and performance numbers.
- Prepare a reference reading list with direct links to papers, libraries, and tutorials.

Which next step would you like? If you want the Markdown export or a comparison table, tell me the format (Markdown, CSV, Google Sheet) and I’ll produce it.
