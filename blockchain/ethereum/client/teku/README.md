# Teku Consensus Client

The blob is byte vector. Simple serialization supports byte vector and list. The blob schema tell developers how to create blob from byte vector. The blob sidecar is a complete data container of all data fields related to blob such as index, blob bytes, proof, commitment, signed beacon block, slot and etc.

The beacon block has slot, proposer index, parent hash, state hash and block body. The root hash of this block can be calculated by its data fields. The beacon block can be constructed from genesis state. The blindness of block is determined by block body. The body hash root takes part in block header. 

The class is provided to get data object from ssz bytes form. Justified and finalized are two types of checkpoints. The beacon node needs to know how many deposits are submitted in the execution layer as well as timestamp and hash proof. 

A function is callable and a thread is runnable. They can be executed in the asynchronous mode. The future is delayed waiting result. The task queue can be throttled. The task can be scheduled by timer. The BLS crypto algorithm is implemented by java language. The key store for BLS cryptography is specified. Limited collections are constructed in java language. 

The event mechanism is written by java language. There are event channel, event deliver and event consumer concepts and code items. HTTP is network protocol for networking functionalities. IO is data storage protocol for file reading and writing in the local file system. The infrastructure folder contains common libraries for upper application codes.

The KZG cryptography is implemented by c language. Its interfaces are called via JNI method. The trust setup is loaded at first step. It is able to do the verification work when blob data, commitment and proof are known. The commitment is computed on the basis of blob data. The proof is calculated based on the blob and commitment data. KZG is powerful when it is used in batch mode. The commitment and proof have several different data formats which are transformable. 

The networking directory offers the network capabilities which includes P2P protocol, gossip protocol, subnet protocol, discovery protocol and peer manager. It routes the messages between different peers. The peer can publish and receive messages from each other.

The storage folder provides data storage layer which contains data channel API, store, data schema and low-level storage databases as well as some storage features like hot data, cold data, archival data and data prune. The database or file storage are basic storage medium. The schema tells how to store the data. The API provides data storage features like access, write, query, delete and cache.

The interface, abstract class and concrete class are coding pattern in object programming paradigm. The software program is a system which should be organized and managed well. The codes from parent class is executed before the codes in the concrete class. The design pattern leads to the ordering of execution. The node types are classified as beacon node and validator node.

The command line has options and arguments. The converters are needed for options' values. The concatenation of configuration, optional values and arguments will choose node type and node service controller from node facade class. It is one command for two node types.

The specification object has fork information. The network specification is composed of forks, fork schedule and state transitions. Every fork has its specific configuration and capabilities. The block and state provider can offer the block and state data object for further processing. The block tree is constituted by block hash node. 

The new state is generated when new block is processed with previous state. The tasks are queued in the memory cache and statistics are counted. The state can be rebased and archored. The ancestor block and state should be founded and consensused for new era. Known states can be cached for performance. The base state is selectable by options and algorithms.

The PoW chain provides JSON-RPC and Execution Engine API. The client can fetch data from these APIs for block and execution payload. The state can be from genesis, initial, custom and checkpoint. There is a period of weak subjectivity from epoch start to epoch end. The period of weak subjectivity can be calculated. The time span is the period of weak subjectivity from start epoch to its sum with calculated period.


