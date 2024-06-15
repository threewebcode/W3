# Synchronization

The entry point is located at the file `eth/sync.go`. The data type of chain synchronizer is defined in that file. It is a struct data type. It has the members of timer, handler and message channels for event and done. The synchronization operation is scheduled to do the synchronization work. All of necessary synchronization information are told by the synchronization operation data object.It includes the synchronization mode, target peer, and head hash. 

The synchronization work is triggered by the loop method and continues to run in the forever mode. Both of block fetcher and transaction fetcher are started. The synchronization operation is forwarded to next process. The select channel statement is used for communication between different goroutine. The peer is filtered by the total terminal difficulty. 

The synchronization mode is detected by trying method. If the snapshot mode is loaded successfully, it is recongnized and processed in that way. The last pivotal block number is stored in the raw database. If the current block number is less than the last pivotal block number, the snapshot synchronization is used to fix this gap between the current block number and pivotal block number. If the right state is not found by the block hash, the snapshot synchronization is also used to heal the state discrepancy. The last resort is the full synchronization.

The essence of synchronization is to obtain the forward or backward data from remote peers and catch up with peers. The synchronization is delegated to handler and finished by the downloader. The handler is a big object which is shared by different components. The raw data type of synchronization mode is integer and its string format is seen when it is necessary. 

The three import objects are downloader, skeleton and state synchronizer.
