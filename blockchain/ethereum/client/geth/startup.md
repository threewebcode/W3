# Launch Ethereum Node

1. command line
    - entry file: `cmd/geth/main.go`
    - main function
        - run the command application created in the package `init` function
        - use the action function of `geth` root command to start full node
        - execute the prepare step
            - check the network name
            - check the cache setting
            - start the metrics collector
        - create the full node
            - make the node and configure the node
            - register the ethereum service
            - register RPC filter service
            - register GraphQL service
            - register ethereum statisctics service
            - register engine API service
        - start the node
            - dependent parameters
                - command line context
                - node instance
                - console boolean flag
            - start the node by the utility function
                - execute the node's `Start` method
                - goroutine to monitor shutdown through signal
            - separate goroutine for wallet management
            - spawn a standalone goroutine for status synchronization monitoring
        - wait for node's shutdown

2. node class

