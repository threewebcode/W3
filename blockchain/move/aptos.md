# APTOS

The move language is offered to write the smart contracts. The smart contract is organized into modules. A module is a collection of related functions, structs, and resources that can be published to the aptos network. The smart contract is called by the available SDK. 

## SDK

1. TS SDK

```bash
curl -fsSL "https://aptos.dev/scripts/install_cli.py" | python3
npm i @aptos-labs/ts-sdk
git clone --depth 1 https://github.com/aptos-labs/aptos-ts-sdk
npm init && npm add -D typescript @types/node ts-node && npx tsc --init && mkdir src && echo 'async function example() { console.log("Running example!")}; example()' > src/quickstart.ts
```
The account is created from the private key. The abstract account is composed of public key, address, signing schema and different generation functions. The signer has the private key and account address. The account is implemented by different cryptography algorithm. There are normal account, keyless account, multiple keys account, single key account.

The apis are constructed around the account object and able to do query and post requests. The domain name service is also provided by the aptos network. The aptos is the entry point and facet of all other specific apis. It collects all apis as below:

```
applyMixin(Aptos, Account, "account");
applyMixin(Aptos, AND, "and");
applyMixin(Aptos, Coin, "coin");
applyMixin(Aptos, DigitalAsset, "digitalAsset");
applyMixin(Aptos, Event, "event");
applyMixin(Aptos, Faucet, "faucet");
applyMixin(Aptos, FungibleAsset, "fungibleAsset");
applyMixin(Aptos, General, "general");
applyMixin(Aptos, Staking, "staking");
applyMixin(Aptos, Transaction, "transaction");
applyMixin(Aptos, Table, "table");
applyMixin(Aptos, Keyless, "keyless");
applyMixin(Aptos, AptosObject, "object");
```
The codes under the transactions directory supply all kinds of transaction factory approaches. After the transaction is constructed, the signer can send it through the client and API. The account sequence number, asynchronous queue, and transaction worker should be managed. The transaction builder is used to produce the transactions. 

The transaction has the transaction arguments and transaction payload. There are raw transaction, simple transaction and signed transaction. The simple transaction can include the raw transaction. The simple transaction becomes the signed transaction after its signature is signed. 

When the contract is called, the sender, function, function arguments are needed. The transaction is sent out with the transaction and its signature. The fungible asset is queried by its specific function interface. 

There are two ways of developing the smart contracts. One is to use the generic types for different cases. The other is to use the object and bundle them together from the resource's perspective. 

The name format of a module is unique identifier + double colon + module name. The module is a collection of code items. The use keyword brings dependent items into current module. The syntax of constant variable is constant keyword + variable name + colon + type + equal + initial value. The structure type is used to describe data objects and store them into ledger. 

The relationship between the objects can be association and management. The account is a signer type in the move language. The account has the objects and it is their owner. The object can have an address and there are method of creating the address for the object. 


