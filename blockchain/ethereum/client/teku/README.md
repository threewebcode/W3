# Teku Consensus Client

The blob is byte vector. Simple serialization supports byte vector and list. The blob schema tell developers how to create blob from byte vector. The blob sidecar is a complete data container of all data fields related to blob such as index, blob bytes, proof, commitment, signed beacon block, slot and etc.

The beacon block has slot, proposer index, parent hash, state hash and block body. The root hash of this block can be calculated by its data fields. The beacon block can be constructed from genesis state. The blindness of block is determined by block body. The body hash root takes part in block header. 

The class is provided to get data object from ssz bytes form. Justified and finalized are two types of checkpoints. The beacon node needs to know how many deposits are submitted in the execution layer as well as timestamp and hash proof. 


