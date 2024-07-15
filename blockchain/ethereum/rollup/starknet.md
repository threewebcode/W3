# Starknet

The starknet is a coordinate system, with each component---sequencer, prover, and nodes --- playing a specific yet interconnected roles. The memory pool gateway will receive transactions from the users. The sequencer then incorporates the transaction and marks its state. The prover executes the block, calculates the proofs and submits it into layer one network for verification.

The sequencer receives transactions, orders them and produces new block. The prover generates the proofs for the new block and transactions. It uses the cario virtual machine to run the provable program, thereby creating execution traces necessary for generating snark proofs. The layer one network hosts a smart contract capable of verifying these snark proofs. If the proof is valid, the layer two's root state on layer one network is updated.

The starknet state is a comprehensive snapshot maintained through the merkle tree. The starknet outsources transaction process to the specific entity and then verify their work. The sequencers provide transaction capacity. They order and sequence multiple transactions into a single batch, execute them, and produce a block. The created block is verified by the approver. 

The sequencer must be reliable and high available. The main task of the approver is to validate the work of the sequencers. After processing the transactions in the block, the prover generates a correct proof of transaction processing. The proof is sent to layer one network for validation in the final step. In contract to the sequencer, the prover operates asynchronously and can execute multiple tasks in parallel. 


