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

