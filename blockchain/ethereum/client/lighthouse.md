# Lighthouse Client

The validator and wallet are the main content of account management. The beacon node is the main component in the consensus client. The beacon node is composed of beacon chain, genesis, execution layer, client, processor,http api and p2p network. 

The slasher is an independent program which determines whether the validator is punished or not according to the correct rules and data. To be a honest validator, it should follow the correct rules and meet the data validations. The block and attestations are stored in the database. The verification is performed on each epoch and slot. It will report the slashing data when the violations are found.


