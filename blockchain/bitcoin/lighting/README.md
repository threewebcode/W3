# Lighting Network

The lighting network uses the event-driven architecture which allows for asynchronous result notifications. The peers are managed by the peer manager which has channel manager and gossip synchronization through the peep to peer network. The channel manager can open the message channel between the peers. The gossip messages are sent through peer to peer network. The peer can synchronize the state through the gossip message.


