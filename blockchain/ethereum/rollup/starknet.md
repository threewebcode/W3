# Starknet

The starknet is a coordinate system, with each component---sequencer, prover, and nodes --- playing a specific yet interconnected roles. The memory pool gateway will receive transactions from the users. The sequencer then incorporates the transaction and marks its state. The prover executes the block, calculates the proofs and submits it into layer one network for verification.

The sequencer receives transactions, orders them and produces new block. The prover generates the proofs for the new block and transactions. It uses the cario virtual machine to run the provable program, thereby creating execution traces necessary for generating snark proofs. The layer one network hosts a smart contract capable of verifying these snark proofs. If the proof is valid, the layer two's root state on layer one network is updated.


