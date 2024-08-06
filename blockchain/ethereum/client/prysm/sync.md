# Initial Synchronization

The steps of `Start` function:
1. pass the context and wait for the clock
2. assign the clock as the instance field variable
3. get the genesis valid root from the clock
4. initialize the verify waiter
5. create the blob verifier from the verify waiter
6. get the genesis time from the clock
7. mark the synchronized status when peer and time conditions are not met
8. wait until the minimum peers are reached
9. fetch the original blobs from the ready peers
10. assign the synchronization work in the round robin method
11. mark the completeness of synchronization step.

The function body of `markSynced` function:
1. The field synced is the atomic boolean type
2. set the correct boolean value
3. close the channel

The body of `waitForMinimumPeers` function:
1. determine the required from command line and configuration file;
2. get the finalized checkpoint from the chain object
    1. The checkpoint is composed of state, epoch and root hash.
    2. The finalization state is obtained by the fetcher
    3. The finalized checkpoint is retrieved from the fork store
	1. The finalized checkpoint is a field of the store structure type
	2. The store is a member of the forkchoice object.
	3. The finalized checkpoint of store can be updated through the fork choice's method.
	    1. The update action is triggered when the blockchain service starts
	    2. The blockchain service starts from the saved state
		1. The finalized state at start time is a configuration item.
		2. If the state is not nil, just start the service from this state
		3. It will start from the execution chain if the state is empty
		4. The genesis state or the state from the database will be marked as the startup state.
	    3. The finalized checkpoint is retrieved from the beachon database
3. pass the epoch as the parameter and get the matched peers

4. wait for some time interval if the peers are not ready
5. for loop to wait for the peers.


