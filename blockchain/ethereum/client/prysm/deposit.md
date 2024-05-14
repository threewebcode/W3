# Deposit

## Execution Service

The execution service is started when the beacon node is bootstraped. The execution service is defined in the file `beacon-chain/execution/servicve.go`. The import task of this service is to fetch necessary information from the canonical eth1 chain. These data are cached for later usage in the beacon chain. The data types include the block hash, block header and event logs in the deposit contract. There is also a golang file named `log_processing.go` which is responsible for the collection of deposit contract's events.

## Cache Deposit

The deposit data is handled by the interface `DepositCache` . This interface is declared in the file `beacon-chain/cache/interfaces.go`. The concrete implementation can be found by the contract constraint.

## Process Deposit

The deposit data is the inner field of beacon block body. When the proposer makes the new block, the deposit data is fetched from the cache and inserted into the block body. When the block is processed, the deposit are handled at the same time.


