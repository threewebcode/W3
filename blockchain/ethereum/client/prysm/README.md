# Ethereum Consensus Client

## Architecture

When a client is initialized out of box, it starts a variety of services that run in parallel to handle everything required for the life cycle of the beacon chain. 

- A beacon node which powers the beacon chain of Ethereum consensus.
- A validator client connects to the beacon node and manages staking keypairs.
- A public RPC server to request data about the state, block and validator.
- A p2p network and framework to connect with other beacon nodes.

## Beacon Node

At runtime, the beacon node initializes and maintains a number of services that are all vital to providing the features of PoS Ethereum. 

- A blockchain service which processes the incoming blocks from the network, advance the beach chain's state, and applies the fork choice rule to select the best head block.
- An operation service prepares the information included in the blocks received from peers for inclusion into new validator block.
- A core package containing the beacon chain core functions, utilities and state transitions.
- A synch service which synchronizes the latest canonical head and state, and processes the new block.
- An eth1 service listening to pow blockchain for blocks and deposit data.
- A p2p network which handles the life cycle of node connections and facilitates the broadcasting across the network.


