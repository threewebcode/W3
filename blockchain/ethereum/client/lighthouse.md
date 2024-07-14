# Lighthouse Client

The validator and wallet are the main content of account management. The beacon node is the main component in the consensus client. The beacon node is composed of beacon chain, genesis, execution layer, client, processor,http api and p2p network. 

The slasher is an independent program which determines whether the validator is punished or not according to the correct rules and data. To be a honest validator, it should follow the correct rules and meet the data validations. The block and attestations are stored in the database. The verification is performed on each epoch and slot. It will report the slashing data when the violations are found.

The block queue is represented by the hash set data structure. The process are wrapped and written in the slasher crate. The slasher crate is used in the slasher service. The service is launched to handling process.

The dependent crates can be external and internal. The internal crates can be in the same group. The work group is laid out as the parent and child directories. All of crates are declared in the one yaml file. The crate in the group can reference the crates in the same group since it can find the crate location in the group file.

The discovery is the network protocol built on the p2p network. The peers who join the network will be discovered and shared between the peers. The peer can find and connect with other peers through the discovery protocol. This protocol is implemented as the boot node. 

The signature is produced by the message digest and private key. The signatures can be aggregated. Usually, there are two necessary parts around the crypto data: the original data and crypto proof. The presets comes from the format file. The yaml format is used here. The keyword struct and impl are used to depict one plain data type. The struct has its type name and member fields. The impl bounds the methods with the struct type. The actions are added on the struct type so that it has the behavior capability. 

The unsigned 64 bits type denotes one integer type in Rust. The 64 bits stand for the value range. The committee is cached by the data object. If the first parameter is not the self word, it means that this method is static method. A complete set of operations are achieved by the function definition. The validator is allowed to exit the validation role. The exit cache is the data object which records this aspect. 

The beacon state is partial data of the whole beacon block. The genesis time and state are a special moment. The latter state has a previous state. The states are linked together. The balances are changed between each epoch. The statistics of progressive balances can be carried out for each epoch. The public key makes use of the map data container to store the public keys. 

The validator has the identity of validator index which is number type. The slasher cache tells us which validators are punished and its slot time. The hash set is suitable for this scene. The validator is activated in the epoch unit. The activation queue calculates the activation quantity of the validator in each epoch. The main data of the attestation is the block root hash as well as the slot and final checkpoints. 

The attestation is composed of the attestation data, validator bit list and aggregated signature. The block body is full of certain fields. The payload of the block body is related to the upgrade name. The beacon block header consists of slot number, proposer index, parent root hash, state root hash and body root hash. 

The committee is determined by the slot number, committee index and committee members. The validators are the members of the committee. The validator is identified by the its index number. There are fields in the definition of beacon state type. The binary large object is identified by the block hash and its location index. The binary large object is located inside of the blob sidecar. The blob sidecar has the blob index and actual blob data as well as its proof. 

The execution change is made up of the validator index, public key and account address. The account address is the receipt account of transaction fees and gases. The chain specification has the complete data sets of variable names and their values. The epoch and block root hash constitutes a checkpoint. The checkpoint is used to check the finality of block root hash at the specific point of epoch. In an epoch, there should be one valid block root hash which represents the finality of the blockchain ledger. 

The rewards are mathematical calculation. The deposit is verified by the merkle tree. The deposit data are the leaf on the tree. The deposit data is organized by the merkle tree. The validators participating in the attestation can be calculated from the committee and attestation bit list. The attestation bit list indexes the validators who take part in the attesting activity. 

The indexed attestation compasses the attestation data and validator indices who vote the attestation. Every validator has its balance in the beacon state. This balance can be increased or decreased according the reward and penalty. The epoch is the key and unit. The epoch-related data are stored in the cache. There are pre and post hook for block processing. The valid blocks are selected from the block list and replayed again the current state.

The command line application has several commands. Each command is one instance of command data type. Every command has the complete properties like name, description and arguments. The command collects the data from the command terminal. The execution of the command in the match clause. There is configuration object with many setting items. 

If the validator is attesting the block honestly and correctly, his right behavior could be rewarded. The attestation reward is calculated at the last slot of next epoch. The attestation reward is computed for every validator with the help of the beacon state data. 

The block hash is calculated according to the rules of execution layer. To compute the block hash, the parent block hash and payload body should be known. The data are encoded by the RLP protocol. The execution block has the enough details in the side of execution layer. More upgrades, more fields in the execution payload. The API capability is the state of boolean flags. 

The different hash algorithms may be used so that there may be some differences between the sides. The execution block is at the side of execution layer. The execution block is correlated with the beacon block. Both of them have the same data structure and synchronized with each other. The validator has to do staking to take part in the consensus process. The stating is equal to the deposit in the execution layer. The beacon node has ethereum package for this deposit aspect. 

The deposit staking is the one kind of transaction in the execution layer. This kind of transactions are included in the block. The beacon node can fetch the execution block and get the deposit data from the deposit transactions in the block. 

The data are chunked pieces. The vector is used to represent the collection of chunked data. The chunked data should be iterated for each piece. The chunked data should be written and read. There are memory storage and file system storage. The level database is the formatted file system storage. The data of transaction, payload, block and world state are stored. The attestation, slash, reward, aggregation synchronization and execution change are main operations in the consensus layer. 

The queue and worker are used to process the messages from the network. 
