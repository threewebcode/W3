# Lodestar Client

The proof is the merkle tree and its root hash. The block, state and transaction list have their proof. They should be verified to ensure its correctness. The blocks are processed in the batch mode. The batch size controls how many blocks are processed in one time. The block data are migrated from current hot storage into the cold storage. The blob sidecars are also migrated at the same time. 

