# Execution Engine

The execution engine has four methods and it is interface type. It is one member of engine controller structure type. It can get executed payload or post a new payload from the block.

Batch Queue:
  * structure type
  * member list:
    * rollup configuration
    * next batch provider
    * original block
    * block list
    * batch list

The batch queue can accept new batch and pop batch from the queue.  The batch queue is a queue for batch. The block list is used for mapping and validation.

Batch Interface:
  - get batch type
  - get timestamp
  - as single batch
  - as span batch

The batch has type and timestamp. It can be either single batch or span batch. The batch contains batch data which is encoded and decoded by RLP algorithm.


