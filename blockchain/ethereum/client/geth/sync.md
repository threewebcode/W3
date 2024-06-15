# Synchronization

The entry point is located at the file `eth/sync.go`. The data type of chain synchronizer is defined in that file. It is a struct data type. It has the members of timer, handler and message channels for event and done. The synchronization operation is scheduled to do the synchronization work. All of necessary synchronization information are told by the synchronization operation data object.It includes the synchronization mode, target peer, and head hash. 


