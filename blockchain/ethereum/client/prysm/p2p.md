# P2P Network

The send method can write the message into the stream and transmit it to the specified peer. The broadcast method can send the message the peer list in the network. The message type is mapped with corresponding topic. It is easy to find the message topic by reflecting the message type.

The peer to peer network has the capacity of publishing the messages into the topic channel. The messages are received by the peers in the network. The peers who suscribe the message topic can use its register handler to process this message data. 


