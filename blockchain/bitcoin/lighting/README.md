# Lighting Network

The lighting network uses the event-driven architecture which allows for asynchronous result notifications. The peers are managed by the peer manager which has channel manager and gossip synchronization through the peep to peer network. The channel manager can open the message channel between the peers. The gossip messages are sent through peer to peer network. The peer can synchronize the state through the gossip message.

The channel state can be stored at any storage. The block header information and transaction information can be passed from the API. The channel can manage the input and output of final transactions on the bitcoin network. The unspent transaction output is managed by the wallet. 

The channel and block are monitored and bounded together. When a new channel is opened, the channel manager should know this new channel and monitor it. When the new block is mined and finalized, the monitor will notify the channel and update the channel state.

The block source provides the source data from the blockchain network. The transaction can be sent from the broadcast interface. 
