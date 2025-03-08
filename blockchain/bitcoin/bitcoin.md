# BitCoin

There are some datas in the transaction input and output. These data will be used to compose a complete Bitcoin Script. This script is executed in the stack machine to check the transaction validity. The valid transaction is prerequist of confirmed transaction. When the transaction is confirmed, the UTXO view in the ledger will be updated to accept the state transition caused by the confirmed transaction.

The transaction will become valid transaction after it passes checking rules. The valid transaction will be added into memory pool. The memory pool will manage the dependent relationship or parent-child relationship between these unconfirmed transactions. The transaction may be evicted when their dependent transactions are not confirmed.

The transaction version determines transaction structure. The basic transaction structure includes transaction input, output and witness. The validity of transaction structure can be checked according to transaction version. The transaction types are evolved from legacy types to other advancded types. The original public key is replaced by public key hash or tweaked public key. To make it more dynamic, the public key can be replaced by a redeem script. The formated script can spend the bitcoin output.
