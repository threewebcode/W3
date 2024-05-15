# Beacon RPC

## Endpoints

There is a file named `endpoints.go` under the folder `beacon-chain/rpc`. All endpoints in the beacon node are defined in this file. There are beacon, node, validator, reward, blob, builder, config, debug, event and other endponts. Each endpoint may has GET or POST methods for data operations. 

## Beacon Block API

The block namespace has several RPC APIs. In this section, only the block writing API is focused and descrbed. The block writing method can accept the block parameter and write the data into beacon node. 

The code snippet of block write operation as below:

```go
                {
                        template: "/eth/v1/beacon/blocks",
                        name:     namespace + ".PublishBlock",
                        handler:  server.PublishBlock,
                        methods:  []string{http.MethodPost},
                }
```

The `PublishBlock` acts as the main handler for the POST http request. The main procedures of `PublishBlock` method can be summaried as below:


