# Lighthouse Client

The validator and wallet are the main content of account management. The beacon node is the main component in the consensus client. The beacon node is composed of beacon chain, genesis, execution layer, client, processor,http api and p2p network. 

The slasher is an independent program which determines whether the validator is punished or not according to the correct rules and data. To be a honest validator, it should follow the correct rules and meet the data validations. The block and attestations are stored in the database. The verification is performed on each epoch and slot. It will report the slashing data when the violations are found.

The block queue is represented by the hash set data structure. The process are wrapped and written in the slasher crate. The slasher crate is used in the slasher service. The service is launched to handling process.

The dependent crates can be external and internal. The internal crates can be in the same group. The work group is laid out as the parent and child directories. All of crates are declared in the one yaml file. The crate in the group can reference the crates in the same group since it can find the crate location in the group file.

The discovery is the network protocol built on the p2p network. The peers who join the network will be discovered and shared between the peers. The peer can find and connect with other peers through the discovery protocol. This protocol is implemented as the boot node. 


