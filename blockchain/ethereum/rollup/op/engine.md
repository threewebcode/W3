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

Data Type of Sequencer Structure:
  - context
  - rollup configuration
  - chain specification
  - state listener
  - conductor
  - asynchronous gossip
  - event emitter
  - attribute builder
  - origin selector
  - building state

The sequencer instance listens on the event and trigger specific event handling. The payload attributes are prepared before building new block. The payload attribute is emitted by build start event.  The most important method of sequencer instance is event listener method. It will process all kinds of events which it is able to process.

The attributes in OP:
  - payload attributes
  - Eth block reference
  - OP block reference

The payload attributes are prepared with additional transactions which are not normal OP user transactions. The attribute queue has the property of batch queue. The attributes can merge the transactions from the batch.


