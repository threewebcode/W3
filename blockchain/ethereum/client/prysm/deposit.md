# Deposit

## Execution Service

The execution service is started when the beacon node is bootstraped. The execution service is defined in the file `beacon-chain/execution/servicve.go`. The import task of this service is to fetch necessary information from the canonical eth1 chain. These data are cached for later usage in the beacon chain. The data types include the block hash, block header and event logs in the deposit contract.

## Cache


