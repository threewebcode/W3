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

The queue and worker are used to process the messages from the network. When the node starts, it should catch up the latest state or start from the genesis state. The configuration or command line options can change the execution routine and behavior. The checkpoint is safe and quick way of synchronizing the state with the remote peers.

## State Synchronization

1. Network Context

All aspects of request context are defined in the request file. The enumeration type is used to list all possible errors which may happen during block lookup verification. The block and blob are two kinds of data that should be fetched from the whole network. The request for block and blob data are described and its response is also correlated. 

Self, crate, super, parent are the path keywords in the rust language. Its meaning should be clarified when it appears in the use statements. The request can be divided into range request or no range request. The categories of range request can be either forward lookup or backfill request. The batch id is used to identify the request. The empty curly bracket and curly brace with colon are equal. The placeholder is replaced by the string format of the target object which implements the display trait. If the target object implements the debug trait, it can be well printed by the curly brace with colon and other symbols like question mark, hash tag and hex indication.

The peer is recognized by the peer id and selected from the peer list. When the peer is known, the request is sent to it for data extraction. 

2. Peer Type

The remote peer may be fully synchronized with local peer. It may be advanced or behind than the local peer. The local peer should synchronize with the advanced remote peer. The synchronization information is the record data of state information of each peer. The peer type is determined by the synchronization information and its comparison 

3. Backfill Synchronization

The backfill structure is very abstract and can be suitable for different beacon chain types. As a result, the generic type is annotated in the definition of type declaration. The module is defined and the items in the module is imported and exported. If there is another word instead of use keyword, it would be better.

4. Range Synchronization

The batch is the slot range. It is a scope of beginning slot and end slot. The block root is managed by the fork choice. There are two chains. One is the finalized chain, the other is the head chain. The synchronization information is compared between the local peer and remote peer. The finalized epoch and current head should be compared to know the distance between the local peer and remote peer.

The closure function can be passed as the input parameter and executed in the function body. The chain collection is data structure which has the chain data fields and offers the methods to operate on these chain data. The operations include updates and processes the chain data. 

## Network

1. P2P Network

The message queue and topic mechanism are used in the peer to peer communication. The database is harnessed to store the peer data. The node has its peer identity and ethereum node record. The client is derived from the peer information. Each message is an instance of enumeration type. The actual data is embedded into the enumeration object. 

2. Peer Manager

The module can be used internally or externally. The peer manager structure type is managing and handling the peer's reputation and connection status. The events happened in the peer's activities are incoming connection, outgoing connection, disconnection, status, ping, ban, unban, discover and subnet. The module entry file brings other module items into the current scope and export the main peer manager object which utilizes the imported module items.

The libp2p crate is the important dependency in the lighthouse network. The traits from the libp2p are implemented for the peer manager so that the peer manager can take part in the network activity. The hash map is used to store the known peers. The peer's reputation is represented by its score. 

## Beacon Chain

1. Data Types

There are beacon store and forkchoice store. The hot and code data are separated. The beacon chain type is the generic type parameter of the beacon chain structure type. The three main actions of beacon chain are choosing the head chain, importing the blocks and block operations. The canonical head, finalized checkpoint, justified checkpoint are stored in the block ledger store. 

The beacon chain is a very big data structure with many fields. It means that it is a complex object and act as the important role. The order of the slot is used to determine the state of block. If the slot is finalized, the state caused by the slot is also finalized. The forkchoice is persisted in the database by its special key. 

2. Data Availability

The member fields of the pending execute block:

  - signed beacon block
  - state root and its hash 256 value
  - parent block
  - parent finalized data at the execution side
  - confirmed state roots
  - consensus context
  - payload verification result

The data structure of state cache:

  - state vector
  - beacon store
  - chain specification

The state root acts as the key and the state itself as the value. This pair is used to store the state in the cache storage. 

The data structure of pending component:

  - block root
  - verified blobs
  - verified data column
  - executed block

The methods of pending component:
  * is available
  * make available
  * get epoch from the block or from the verified blob's slot
  * blob index and data in the block
  * block index as key to store blob in the cache

The state cache and chain specification are used to do the validation and verification of data availability. The blob can be extracted by its index. The move keyword can be applied into the closure function and asynchronous codes. It is loop statement which execute the proposer preparation. The task is executed after some time duration. The macro rules are utilized to add more code items into the existing type. 

When the blob, block commitment and proof are provided, their relationship is verified by the cryptographic algorithm. There are three factors for the verification: blob data, commitment and proof. The tuple structure is harnessed to track the head. The tuple element is hash map type. The key of hash map is the head root and the value is the block slot number. 

The fork choice's slot is updated when the fork choice completes its process. The execution payload should be prepared at the execution layer. It contains transactions. The reference of execution layer is obtained for the next action. The block hash for the execution payload is calculated. The block hash is leveraged to get the payload from the execution layer. The let keyword can be used to introduce a new variable.

The asynchronous function is defined and executed with the await keyword. The execution payload is constructed from the execution layer. The payload attribute can generate the unique identity. The checkpoint may be either justified or finalized. 

The body of compute reward function:
  * compare the slot and ensure that the block slot is equal to the state slot
  * pass the state as input parameter and update the reward cache
  * get the total active balance from the state
  * get the intersection set of attestations between the block and state
  * iterate the attestation set and compute the attestation reward
  * sum the total attestation reward
  * compute the sync committee reward
  * produce the total block reward
  * put the values into the structure data type and return this object

The blinded block will become signed block. The signed block will become verified block. The signature verified block will become execution pending block. The execution pending block will become justified and finalized block. Many errors may happen with execution payload. These errors are enumerated as the enumeration type. The state object has the epoch field. 

The objected is encoded and serialized before it is written into local file. The block contains the blob indexes. The identifier of blob is the combination of block root plus the blob index. The fork choice can be reverted to the finalized checkpoint or to the trust and safe boundary when it is necessary. 

The composition of beacon snapshot is beacon block, block root and beacon state. The proposer is composed of the fork and its index value. The proposer data is cached. The key is the tuple type with elements of epoch and block root hash. The value indexed by the key is the proposer index value in the validator list. 

The state root is a member of the block header. The checkpoint includes the epoch and block root hash. The versions between the memory and persisted storage can be converted. 

## Consensus

1. Data Types

The balance is made up of amount and minimum. Both of them are unsigned integer type. The public key is the identifier of the validator. The validator index is its position in the validator list. 

The body of block header:
  * slot
  * proposer index
  * parent root
  * state root
  * body root

The header block tell us when and who proposes this block and its data relationship internally and externally. It has several methods to support its operations. The header can be derived from the block. The block has the block body. The block body is a big data structure with many fields.

The data structure of the blob sidecar:
  * blob index
  * blob data
  * kzg commitment
  * kzg proof
  * signed block header
  * commitment inclusion proof

The beacon state is a general term and has several fields which are used to cover the necessary data in the network. 

The composition of beacon state data structure:
  * genesis time
  * genesis validator root
  * slot number
  * fork data
  * block header
  * block roots
  * state roots
  * historical roots
  * eth1 data
  * eth1 data votes
  * validators
  * balances
  * random mixes
  * slashings
  * previous epoch attestations
  * current epoch attestations
  * previous epoch participation
  * current epoch participation
  * justification bits
  * previous justified checkpoint
  * current justified checkpoint
  * finalized checkpoint
  * inactivity scores
  * current sync committees
  * next sync committees
  * latest execution payload header
  * next withdrawal 

The method set is added to allow the operations on the member fields. The block, payload and state are data objects which need to be stored into persistent storage. 

The method set of fork choice store trait:
  * get current slot
  * set current slot
  * on verified block
  * justified checkpoint
  * justified balances
  * finalized checkpoint
  * unrealized justified checkpoint
  * unrealized finalized checkpoint
  * set justified checkpoint
  * set finalized checkpoint
  * set unrealized justified checkpoint
  * set unrealized finalized checkpoint

The beginning and end slot of epoch can be calculated. The slot knows which epoch it is located. The update parameter of fork choice includes head root, head hash, justified hash, finalized hash. The fork choice provides the view of head block root, justified checkpoint and finalized checkpoint. 

The member fields of fork choice data structure:
  * fork choice store
  * protocol buffer array
  * vector queue of attestations
  * fork choice update parameter
  
The anchor fork choice can be from the genesis state or the finalized checkpoint. The execution status is confirmed from the execution layer side. 

The statements of get head function in the fork choice object:
  - update the time with the system time current slot 
  - get the data from the fork choice store and use them as the condition to get head from protocol array 
  - use the head root to find the block 
  - use the justified hash to find the block and get the block hash from the block 
  - use the finalized hash to find the block and get the block hash from the block 
  - put the head root into the result enumeration and return it as the function output

## Genesis

To reduce the length, the word is shorted. The deposit data is one part of the genesis state. The deposit data and proof constitute the whole deposit object. Since the beacon side needs to know the deposit data and some block information from the execution layer, the genesis service is created to fulfill this responsibility. The genesis state can be initialized from the execution layer data.

The client is a term which is used to describe the beacon node. The synchronization is included in the network service. 

## Network

The network is one kind of services in the beacon node. The network service is an asynchronous service with its start method. In the static start method, it uses its build static method to create the network instance. The router is spawn in the build method. The router service starts the synchronization manager. After the network service is instantiated, other services associated with network service are spawned and executed by the task executor.

In the Rust programming language, the `mpsc` (Multiple Producer, Single Consumer) package provides a way to implement asynchronous communication between different parts of a program. The `mpsc` module includes two types of channels: the bounded channel and the unbounded channel.

The main difference between the bounded and unbounded channels in the `mpsc` package is the handling of backpressure. The bounded channel will block the sender when the channel's capacity is reached, while the unbounded channel will not block the sender, potentially leading to increased memory usage.

## Execution Layer

The execution layer adopts RLP encoding. The new block root hash can be calculated by parent root hash and execution payload. During the procedures of calculation, the block header is constructed with each field value. The contract execution log can be retrieved from the execution side via API. The consensus side is only interested in the deposit logs. The execution payload has the main data fields from the execution layer. It is consumed by the consensus layer.

The deposit object is created from deposit data. The deposit object has two fields: data and proof. The proof is merkel tree proof. The deposit data, blocks and transactions from execution layer are the main data sources which are useful for consensus side. The genesis state of consensus side can be computed with the help of deposit data and genesis block from execution layer. The execution service can fetch the blocks from the execution layer. 

The genesis time, block hash and execution payload header from execution layer take part in the genesis state in the consensus layer. The metrics is an independent http namespace which is hosted by http framework. The registered http handlers are used to process the incoming metrics http requests. The issue about the attestation should be specified. From the issue and perspective of design, try to understand the data type and structure. Moreover, processing algorithm can be clarified to explain data organization operation.

There are mature http client libraries which can be used to construct specific http client and send http requests to target server. The block root hash can be regarded as id of block. The block can be found by block root hash. The block contains state root hash so that beacon state can be found by state root hash. The expected data can be computed from block and state objects. In light of known blocks, block reward can be calculated for each validator by checking whether it did attestation work successfully.

The consensus version is determined by fork name. Small pieces of process units are combined to construct a bigger process unit. The duty of proposers are computed at the side of beacon node. The validator client can know this result by sending request to beacon node. The block root hash is the truth. The proposer is the actor who tells the truth. The slot is the time of when the proposer tells the truth.


