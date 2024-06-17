# Initial Synchronization

When the finalized epoch is known, the synchronization can start the synchronization and push the local state to the designed target. The remote peers are selected and blocks are fetched from these peers. The missed blocks are executed to catch up the progress. If the gap is alreaded fixed, the process will turn to non-finalized case. 

The last known state can be either genesis state or intermedium state. It goes from the last known state to thehighest finalized state providing by the surronding peers. After the finalized state is finished, it starts to do the synchronization of non-finalzied state.


