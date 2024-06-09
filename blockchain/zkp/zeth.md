# ZK Ethereum

The ethereum virtual machine has the rust version. It can be brought into current crate for direct usage. The transaction in the ethereum should have execution strategy. It is all about executing transactions in the virtual machine. When executing a transaction, all of block enviroment, transaction environment and virtual machine environment are needed. When the withdrawl data in the block body, the balance of its corresponding address should be increased.

The rust trait is used to abstract the transaction execution strategy. To finalize the block, the strategy is also needed. When the block is finalized, the state trie is determined. The state root in the block header is updated. 


