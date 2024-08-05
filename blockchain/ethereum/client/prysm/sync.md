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


