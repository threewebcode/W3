# Ethereum Backend

1. Ethereum Data Structure
    - source location: `eth/backend.go`
    - composition fields
        - ethereum configuration
        - transaction pool
        - blockchain
        - handler
        - ethereum dial candidates
        - ethereum snap candidates
        - chain database
        - consensus engine
        - account manager
        - bloom requests
        - bloom indexer
        - ethereum API backend
        - miner
        - gas price
        - network id
        - network RPC service
        - p2p server
        - mutual exclude lock
        - shutdown tracker

2. Ethereum Factory Function
    - function name: `New`
    - function arguments
        - node
        - ethereum configuration
    - function body
        - check sync mode and ensure its value is sane
        - trie cache assignment
        - open chain database
        - state schema check against chain database
        - load the chain configuration from genesis and database
        - build consensus engine upon chain configuration and database
        - read the chain id from command configuration or chain configuration
        - make field variables ready and direct initialization of `Ethereum` struct
        - declare and initialize the virtual machine configuration
        - define cache configuration variable and assign the initial value
        - set the value of virtual machine trace
        - produce the blockchain instance and assign it as the field of ethereum instance
        - generate transaction pool instance and perform the field assignment
        - fabricate the miner instance on the basis of miner configuration and consensus engine
        - bind the miner instance as the field value of ethereum instance
        - make the ethereum api backend instance and store it as the field value of ethereum instance
        - manufacture the network RPC depending on the p2p server and network id
        - copy the ethereum apis to node
        - copy protocols from ethereum to node instance
        - register ethereum as the lifecycyle of node

3. Ethereum APIs
    - methods name: `APIs`
    - return type: slice `rpc.API`
        - namespace field
        - service field
    - method body
        - get api list from api backend
        - append consensus engine's aps set
        - append miner, eth, admin, debug and net api list

4. Ethereum Start
    - method name: `Start`
    - method body
        - start ethereum name record updater
        - start bloom handler
        - start ethereum network handler

