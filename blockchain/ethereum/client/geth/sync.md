# Synchronization

The entry point is located at the file `eth/sync.go`. The data type of chain synchronizer is defined in that file. It is a struct data type. It has the members of timer, handler and message channels for event and done. The synchronization operation is scheduled to do the synchronization work. All of necessary synchronization information are told by the synchronization operation data object.It includes the synchronization mode, target peer, and head hash. 

The synchronization work is triggered by the loop method and continues to run in the forever mode. Both of block fetcher and transaction fetcher are started. The synchronization operation is forwarded to next process. The select channel statement is used for communication between different goroutine. The peer is filtered by the total terminal difficulty. 

The synchronization mode is detected by trying method. If the snapshot mode is loaded successfully, it is recongnized and processed in that way. The last pivotal block number is stored in the raw database. If the current block number is less than the last pivotal block number, the snapshot synchronization is used to fix this gap between the current block number and pivotal block number. If the right state is not found by the block hash, the snapshot synchronization is also used to heal the state discrepancy. The last resort is the full synchronization.

The essence of synchronization is to obtain the forward or backward data from remote peers and catch up with peers. The synchronization is delegated to handler and finished by the downloader. The handler is a big object which is shared by different components. The raw data type of synchronization mode is integer and its string format is seen when it is necessary. 

The three import objects are downloader, skeleton and state synchronizer. When the state root is provided, the state synchronization can begin. The task and status are written into the specific channels. The state fetcher reads the state synchronization task from the channel and starts to do its work. The snapshot synchronizer is used to synchronize the state root. 

Regarding to the synchronization, three aspects need to be considered. They are synchronization algorithm, best peer selection and state coordination. The block and state are synchronized from the remote peers. The block and state are categoried into full synchronization types and snapshot synchronization types. The block and state date are fetched in the range and batch manner. The most important parts of state are the account and smart contracts.

When the accounts and storage slots are downloaded from the remote peer, the state trie can be reconstructed withe provided data. All of error scenarios are predicted and handled. The heal processor is used to cope with the unexpected situation. The synchronizer will assign the account, bytecode and storage tasks to idle peers. The seperate routine is used to handle the received data. 

The snapshot protocol is composed of data types and interfaces. The interfaces are the contracts and constraints. The data types are the input and output data. When the response is returned from the remote peer, the peer information and data packet are known. The snapshot protocol follows the p2p protocol. The lifecycle of peer methods are handled by the handle processor. The message type is recognized by the code property of the message. The dispatcher is sending the request and processing the response. 


