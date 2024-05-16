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

1. determine the request type. If it is ssz version, go through the ssz handler function.
2. read the request body and unmarshall it to beacon block type.
3. validate and broadcast the block to p2p network.
4. process the block at the local node.

This server side's API is consumed by the validator client. It is invoked in the body of method `ProposeBlock` from the validator instance.

The main steps in the `ProposeBlock` method:

1. get the beacon block by the conditions of slot, randao and graffiti.
2. sign the block.
3. call ProposeBeaconBlock method to send the beacon block.


