Quantum computing has the potential to break many of the existing cryptographic algorithms that are commonly used today, particularly those based on the integer factorization and discrete logarithm problems, which are the foundation of public key cryptography. To resist quantum computing attacks, researchers are actively developing and studying post-quantum cryptography (PQC) algorithms. PQC algorithms are designed to be resistant to attacks by both classical and quantum computers. 

Here are a few examples of post-quantum cryptographic algorithms that are currently being researched:

1. **Lattice-based cryptography**: Lattice-based cryptography relies on the hardness of certain mathematical problems related to lattices, such as the Learning With Errors (LWE) problem. Examples of lattice-based schemes include NTRUEncrypt, Kyber, and NewHope.

2. **Code-based cryptography**: Code-based cryptography is based on error-correcting codes. It utilizes the difficulty of decoding certain linear codes that are resistant to attacks by both classical and quantum computers. The McEliece cryptosystem is a well-known code-based encryption scheme.

3. **Multivariate cryptography**: Multivariate cryptography is based on the difficulty of solving systems of multivariate polynomial equations. Examples of multivariate schemes include the Hidden Field Equations (HFE) and the Rainbow signature scheme.

4. **Hash-based cryptography**: Hash-based cryptography is based on one-way hash functions. These functions are used to generate digital signatures, which can provide authentication and integrity. The Merkle signature scheme and the Lamport signature scheme are examples of hash-based signature schemes.

5. **Isogeny-based cryptography**: Isogeny-based cryptography is based on the difficulty of computing discrete logarithms in certain elliptic curve isogeny problems. The Supersingular Isogeny Diffie-Hellman (SIDH) key exchange and the SIKE encryption scheme are examples of isogeny-based algorithms.

Open-source projects related to post-quantum cryptography (PQC) algorithms on GitHub:

1. [Open Quantum Safe (OQS)](https://github.com/open-quantum-safe/liboqs): A collection of quantum-resistant cryptographic algorithms, including lattice-based, multivariate, code-based, and hash-based schemes.

2. [PQClean](https://github.com/PQClean/PQClean): Reference implementations of various post-quantum cryptographic schemes, including lattice-based, code-based, and multivariate schemes.

3. [Microsoft PQCrypto-VPN](https://github.com/Microsoft/PQCrypto-VPN): An open-source VPN solution incorporating post-quantum cryptographic algorithms, including lattice-based schemes like Kyber and NTRU.

4. [NIST Post-Quantum Cryptography Competition Submissions](https://github.com/PQClean/PQClean): Submissions from the NIST Post-Quantum Cryptography Competition, encompassing various post-quantum cryptographic schemes.

5. [liboqs-sys](https://github.com/open-quantum-safe/liboqs-sys): Rust crate providing bindings to the liboqs library, a C library for quantum-safe cryptography.

6. [mupq](https://github.com/mupq/mupq): Makefiles and scripts to build and benchmark implementations of post-quantum cryptographic schemes.

7. [PQCrypto-Lattice](https://github.com/PQCrypto/PQCrypto-Lattice): Lattice-based cryptographic algorithms and related tools, including implementations of NIST lattice-based submissions.

8. [Sike](https://github.com/Microsoft/PQCrypto-SIKE): An efficient and secure implementation of the Supersingular Isogeny Key Encapsulation (SIKE) algorithm, a post-quantum key exchange scheme.

9. [LibTomCrypt](https://github.com/libtom/libtomcrypt): A library providing various cryptographic algorithms, including several post-quantum schemes like McEliece, NTRU, and SIDH.

10. [Falcon](https://github.com/falcon-signature/falcon): An efficient and lightweight implementation of the Falcon lattice-based signature scheme.

11. [SPHINCS+](https://github.com/sphincs/sphincsplus): An implementation of the SPHINCS+ post-quantum signature scheme, which is based on the Merkle tree construction.

12. [FrodoKEM](https://github.com/Microsoft/PQCrypto-FrodoKEM): An open-source implementation of the FrodoKEM key encapsulation mechanism, a lattice-based post-quantum key exchange scheme.

13. [Picnic](https://github.com/Microsoft/Picnic): An efficient implementation of the Picnic digital signature scheme, which is based on the zero-knowledge proof system.

14. [Rainbow](https://github.com/rainbow-crypto/rainbow): A library providing implementations of the Rainbow signature scheme, a multivariate cryptographic scheme.

15. [libpolycrypto](https://github.com/ladnir/libpolycrypto): A library offering implementations of various multivariate polynomial-based cryptographic schemes.

16. [CRYSTALS-KYBER](https://github.com/pq-crystals/kyber): A C library providing an implementation of the Kyber key encapsulation mechanism, a lattice-based post-quantum KEM.

17. [NewHope](https://github.com/tpoeppelmann/newhope): A C implementation of the NewHope key exchange algorithm, a post-quantum protocol based on the Ring Learning with Errors (RLWE) problem.

18. [Dilithium](https://github.com/pq-crystals/dilithium): An implementation of the Dilithium digital signature scheme, a lattice-based post-quantum signature scheme.

19. [liboqs-rs](https://github.com/open-quantum-safe/oqs-rs): Rust wrapper for the liboqs library, allowing access to quantum-resistant cryptographic algorithms.

20. [PQCrypto-Archived](https://github.com/PQCrypto/PQCrypto-Archived): A collection of older, archived versions of post-quantum cryptographic schemes and related research.


Open-source blockchain projects on GitHub that are related to post-quantum cryptography (PQC) algorithms:

1. [CIRCL](https://github.com/cloudflare/circl): Cloudflare's cryptographic library that includes PQC algorithms suitable for post-quantum security.

2. [QAN Platform](https://github.com/QANplatform/qanplatform): A quantum-resistant blockchain platform that utilizes post-quantum cryptographic algorithms.

3. [Quantum-Proof Blockchain](https://github.com/JinxiangWu/Quantum-Proof-Blockchain): A blockchain implementation that incorporates post-quantum cryptographic algorithms for enhanced security.

4. [Quantum Resistant Ledger](https://github.com/theQRL/QRL): A blockchain platform designed to be resilient against attacks by quantum computers using PQC algorithms.

5. [PQCHains](https://github.com/pskupinski/PQChains): An experimental blockchain implementation that explores the integration of post-quantum cryptography.

6. [Quantum Dawn](https://github.com/QuantumDawn/QuantumDawn): A blockchain infrastructure project that focuses on quantum-resistant cryptography and security.

7. [QuarkChain](https://github.com/QuarkChain/pyquarkchain): A sharded blockchain platform that aims to provide quantum-resistant security through the use of PQC algorithms.

8. [IOTA](https://github.com/iotaledger): A distributed ledger technology platform that is exploring post-quantum cryptographic algorithms for securing transactions.

9. [ChainZy](https://github.com/chainzy): A blockchain project that emphasizes post-quantum cryptography and secure decentralized systems.

10. [Quantum-Safe Ethereum](https://github.com/ethereum/ethereumj): An Ethereum client implementation that includes research and development on quantum-safe cryptographic algorithms.

11. [qTESLA](https://github.com/qtesla/qtesla): A quantum-resistant signature scheme that can be integrated into blockchain systems for enhanced security.

12. [HoneyBadgerBFT](https://github.com/amiller/HoneyBadgerBFT): A Byzantine fault-tolerant consensus protocol that can be used as a foundation for quantum-resistant blockchains.

13. [QRLJacking](https://github.com/OWASP/QRLJacking): A project that focuses on the security implications of QR code-based authentication, including potential threats from quantum computers.

14. [Quantum-Safe Cryptography and Blockchain](https://github.com/icsi-berkeley/quantum-safe-crypto-blockchain): A research project that explores the integration of quantum-safe cryptographic algorithms into blockchain systems.

15. [Post-Quantum Blockchain](https://github.com/seresistvanandras/post-quantum-blockchain): An experimental blockchain implementation that aims to be resistant against attacks by quantum computers.

16. [Quantum-Safe Blockchain](https://github.com/robertmartin8/quantum-safe-blockchain): A project that investigates the integration of quantum-resistant cryptographic algorithms into blockchain architectures.

17. [Quantum-Safe Token](https://github.com/Quantum-Safe-Token/quantum-safe-token): A project that explores the development of a quantum-resistant token and blockchain ecosystem.

18. [Quantum-Safe Blockchain Infrastructure](https://github.com/Quantum-Safe-Blockchain-Infrastructure): A research project that focuses on developing a blockchain infrastructure that is secure against quantum attacks.

19. [QUANTA](https://github.com/QuantaOfficial/QUANTA): A blockchain project that emphasizes quantum-resistant cryptography and secure decentralized applications.

20. [Quantum-Secure Blockchain Framework](https://github.com/SamuelSt-Jean/Quantum-Secure-Blockchain-Framework): A framework that aims to provide a quantum-resistant blockchain solution by integrating PQC algorithms.

Academic Material

1. https://www.youtube.com/watch?v=XyyGq3GX4K0
2. https://ieeexplore.ieee.org/document/10185538?denied=
3. https://www.nature.com/articles/s41598-023-32701-6
4. https://www.theqrl.org/the-future-of-post-quantum-resistant-blockchains/
5. https://www.nervos.org/knowledge-base/quantum_resistance
6. https://www.researchgate.net/publication/338779877_Towards_Post-Quantum_Blockchain_A_Review_on_Blockchain_Cryptography_Resistant_to_Quantum_Computing_Attacks
7. https://www.researchgate.net/profile/Engin-Zeydan/publication/359440628_Recent_Advances_in_Post-Quantum_Cryptography_for_Networks_A_Survey/links/6255dfd0b0cee02d6966dfc9/Recent-Advances-in-Post-Quantum-Cryptography-for-Networks-A-Survey.pdf

