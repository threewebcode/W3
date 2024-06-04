# Go Ethereum

Ethereum execution client in Go language

## Beacon

### Block Synchronization

1. directory name: `beacon/blsync`
2. light client configuration
    - file location: `config.go`
    - file content
        - define light client configuration struct type
        - structure composition: chain configuration and checkpoint hash
        - manufacture different client variables for different networks
        - provide funtion of creating client configuration instance from the command line context
3. light client
    - file location: `client.go`
    - file content
        - `Client` structure type
            - fields
                - url set
                - custom header
                - chain configuration
                - request scheduler
                - beacon block synchronizer
                - engine RPC client
                - chain head event subscription
                - engine client
            - methods
                - `Start` method
                    - make event channel for chain head
                    - subscribe chain head event
                    - start engine client
                    - start the scheduler
                    - iterate url collection and register beacon api server into scheduler
                - `Stop` method
                    - stop engine client
                    - stop chain head subscription
                    - stop the scheduler
        - `NewClient` function
            - create chain configuration from command line context
            - set up scheduler and block synchronizer
            - instantiate `Client` object
3. beacon block synchronization 
