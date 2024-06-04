# Launch Ethereum Node

1. command line
    - entry file: `cmd/geth/main.go`
    - main function
        - run the command application created in the package `init` function
        - use the action function of `geth` root command to start full node
        - execute the prepare step
        - create the full node
        - start the node
        - wait for node's shutdown
