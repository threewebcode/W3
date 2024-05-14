# Ethereum Consensus Client

## Architecture

When a client is initialized out of box, it starts a varity of services that run in parallel to handle everything required for the life cycle of the beacon chain. 

- A beacon node which powers the beacon chain of Ethereum consensus.
- A validator client connects to the beacon node and manages staking keypairs.
- A public RPC server to request data about the state, block and validator.
- A p2p network and framework to connect with other beacon nodes.


