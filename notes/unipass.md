### Unipass Wallet

UniPass is a decentralized identity management system that uses blockchain technology to securely store and manage personal information. When a user creates an account on UniPass, the platform generates a unique private key for them. This private key is used to encrypt and decrypt sensitive data stored in the user's account wallet.

Here's how UniPass generates the private key and account wallet:

1. The user creates an account on UniPass by providing their email address and password.
2. Once the account is created, UniPass generates a cryptographically secure random number, known as a nonce, which is used to create the private key.
3. The nonce is combined with the user's email address and password using a one-way hashing function, such as SHA-256 or Keccak-256. This creates a unique digital signature that is used to generate the private key.
4. The private key is then generated using a combination of the nonce, the user's email address, and the hashed password. This ensures that the private key is unique to each user and cannot be easily guessed or reverse-engineered.
5. Once the private key is generated, it is used to create an account wallet. The account wallet is a virtual container that stores all of the user's personal information, such as their name, address, phone number, and other identifying details.
6. The account wallet is encrypted using the private key, which ensures that only the user can access their personal information.
7. The encrypted account wallet is then stored on the UniPass blockchain, which is a decentralized network of computers that record transactions and data in a secure and transparent manner.
8. When the user logs into their UniPass account, they provide their email address and password, which are used to regenerate the private key. This allows them to access their account wallet and view their personal information.

Overall, UniPass's approach to generating private keys and account wallets is designed to ensure the security and privacy of users' personal information. By using a combination of cryptographic techniques and decentralized blockchain technology, UniPass provides a secure and trustworthy platform for managing personal information.

### Meta Transactions

Meta-transactions are a feature in the Ethereum blockchain that allows users to perform actions on behalf of another user without needing to hold the private key of that user's Ethereum address. This can be useful in a variety of scenarios, such as when a user wants to authorize another user to perform a specific action on their behalf, or when a user wants to delegate the execution of a smart contract to another user.

Meta-transactions work by creating a new type of transaction called a "meta-transaction". This transaction contains a payload that specifies the action to be performed, as well as the address of the user who will be performing the action. The meta-transaction is then signed by the user who is authorizing the action, and broadcast to the Ethereum network.

Once the meta-transaction is included in a block, the Ethereum network will execute the action specified in the payload, using the address of the user who signed the transaction as the sender. This allows the user who signed the transaction to act as a proxy for the user whose address was specified in the payload, effectively allowing them to perform actions on behalf of that user.

One of the main benefits of meta-transactions is that they allow for greater flexibility and convenience in the way that users interact with smart contracts. For example, a user may want to authorize another user to perform a specific action on their behalf, but they may not want to give that user direct access to their private key. By using a meta-transaction, the user can grant permission for the action to be performed without having to share their private key.

Another benefit of meta-transactions is that they can help to reduce the computational overhead associated with processing transactions on the Ethereum network. Because meta-transactions are essentially just a wrapper around a regular transaction, they can be processed more quickly and efficiently than regular transactions. This can help to improve the overall performance of the Ethereum network, and make it easier for users to interact with smart contracts.

However, it's worth noting that meta-transactions also introduce some additional complexity and security risks. For example, because meta-transactions allow users to perform actions on behalf of another user, there is a risk that a malicious user could use a meta-transaction to impersonate another user and perform unauthorized actions. To mitigate this risk, it's important to carefully consider the security implications of using meta-transactions, and to implement appropriate safeguards to prevent unauthorized access to user accounts.

### Code Navigation

The unipass wallet SDK package is consisted of provider, transaction builder, wallet, session key, keys and network. The provider instance should be created at the fist step. The wallet can be got from the provider instance. The session key is constructed to build the transaction. The actual wallet is made by filling in the keys, RPC url, relayer. The transaction will be sent by the wallet.

The "Wallet" class extends the "Signer" class from the ethers library, which allows it to sign Ethereum transactions. It has various methods for interacting with the Unipass Wallet, such as getting the wallet address, signing messages, estimating gas costs, sending transactions, and more.

The class takes in a set of options when instantiated, including the wallet address, keyset (a set of keys associated with the wallet), context (the Unipass Wallet context), provider (Ethereum provider), and relayer (a relayer service for submitting transactions).

The code also includes other supporting classes and interfaces used by the "Wallet" class, such as "Keyset" (representing a set of keys), "Relayer" (for relaying transactions), "Transaction" (representing an Ethereum transaction), and others.

The class `SessionKey` represents a session key used for cryptographic operations in a wallet system. Here is a breakdown of its key features:

- `userAddr`: A string representing the user's address.
- `isSessionKey`: A boolean flag indicating that the object is an instance of `SessionKey`.
- `wallet`: An instance of `WalletEOA` representing the user's wallet.
- `signType`: An enum value representing the type of signature used.
- `permit`: An optional interface representing a permit for the session key.

The class provides various methods and functionalities, including:

- `digestPermitMessage(timestamp: number, weight: number)`: Generates the digest of a permit message using the user's address, wallet address, timestamp, and weight.
- `generatePermit(timestamp: number, weight: number, wallet: Wallet, signerIndexes: number[])`: Generates a permit for the session key using the given parameters.
- `generateSignature(digestHash: string)`: Generates a signature for the given digest hash using the session key's wallet and sign type.
- `fromSessionKeyStore(store: SessionKeyStore, wallet: Wallet, aesDecryptor: (aesKey: CryptoKey, sig: BytesLike) => Promise<string>)`: Creates a `SessionKey` instance from a session key store, wallet, and AES decryptor function.
- `isSessionKey(v: any)`: Checks if a given object is an instance of `SessionKey`.

The `emailHash` function takes an input email address and a pepper (a cryptographic salt) as parameters and returns a ZK hash for the email address. It first checks if the email address is not null, throws an error if it is, and then converts the email address to lowercase. It then splits the email address into two parts using the "@" symbol. If the second part of the split is one of the specified email domains (gmail.com, googlemail.com, protonmail.com, ptoton.me, pm.me), it removes any dots in the first part and concatenates it with the second part. Finally, it calls the `pureEmailHash` function with the modified email address and the pepper, and returns the result.

The `pureEmailHash` function takes an email address and a pepper as parameters and returns a ZK hash for the email address. It uses the `sha256` function from ethers.utils to compute the hash of the concatenation of the UTF-8 bytes representation of the email address and the pepper.

classes and interfaces related to DKIM (DomainKeys Identified Mail)

- The module exports an interface called `Signature`, which represents a DKIM signature and contains properties for the signature itself, domain, and selector.
- The module also exports an enum called `EmailType`, which defines different types of emails.
- The module defines a class called `DkimParamsBase`, which represents the base DKIM parameters for an email. It has properties such as email type, email header, DKIM signature, from index, subject index, selector index, etc. It also provides methods for serialization, JSON conversion, and string conversion.
- The `DkimParamsBase` class has a constructor, a static factory method `create`, and other utility methods for dealing with email headers and creating instances of the class.
- The code uses various utility functions from the `ethers` library, such as `hexlify`, `solidityPack`, `toUtf8Bytes`, etc.

### Unipass Contract

UniPass Contract is a contract developed by UniPass that enables Role-Based Access Control (RBAC) key management and supports on-chain verification through DKIM/OpenID.

Three main types of key management systems: 1) Multi-signature logic that allows 2/3, 3/5, etc. multi-signature setups. 2) Simple permission management that allows setting weights on keys and performing account operations with a threshold. 3) RBAC-based permission management that allows setting weights and roles on keys. Different roles can execute different operations, and each role has its threshold for activation.

UniPass Contract is a versatile contract that creates smart wallets and mainly handles different types of keys and their permissions. In UniPass Contract, you can manage your account using various keys, each with a specific role and weights. By gathering signatures from keys that meet or exceed the required weights for a certain role, you can execute the permissions associated with that role through the UniPass Contract.

Owner is the account's owner and has the ultimate authority when it comes to controlling the account's basic operations, including deployment, upgrade, and deletion. Operator is the executor of the account's assets and is in charge of all asset transfers, contract invocations, licensing, and other activities. The key that users most used. Guardian is the guardians of the account. Guardians can be used to retrieve the account if the keys are lost or deleted and the user no longer has access to it. On-chain email social recovery is one of the features that only UniPass has.

The Wallet implements a minimal upgradeable proxy pattern, which delegates all calls to the address defined by the storage slot matching the wallet address.

The library consists of two parts: the deployed code and the deploy function.

The deployed code is a series of bytecode instructions that handle the delegation of calls. It starts by copying the call data, then retrieves the implementation address from storage, and finally performs a delegate call to the implementation address. The result of the delegate call is returned as the result of the proxy call.

The deploy function is used to deploy an instance of the upgradeable proxy. It starts by copying the creation code of the library, then stores the implementation address in storage, and finally returns the deployed code.

The contract OpenID is used for managing OpenID related functionality, including validating ID tokens, managing public keys, and managing audiences.

The contract includes the following features:

1. Storage for OpenID public keys: The contract maintains a mapping of keccak256(issuer + key id) to public keys. These public keys are used for verifying the signatures of ID tokens.

2. Storage for OpenID audiences: The contract also maintains a mapping of keccak256(issuer + audience) to a boolean flag indicating whether the audience is valid or not.

3. Updating and deleting OpenID public keys: The contract provides functions to update and delete OpenID public keys. These functions can only be called by the contract admin.

4. Adding and deleting OpenID audiences: The contract provides functions to add and delete OpenID audiences. These functions can only be called by the contract admin.

5. Validating ID tokens: The contract includes a function to validate ID tokens. It verifies the signature of the ID token using the corresponding public key and checks the validity of the timestamp, issuer, audience, and other parameters.

### Solidity Contracts

It contains various functions for reading and manipulating byte arrays. The library is used to handle byte array operations efficiently in smart contracts.

In Solidity, the using keyword is used to bring the functions of a library into the scope of a contract. It allows you to access and use the functions of a library directly without having to explicitly call the library name.

The using keyword is followed by the name of the library and the for keyword, and it is typically used inside a contract definition. In Solidity, the error grammar is a syntax that allows you to define custom error types. The error grammar was introduced in Solidity version 0.8.0 and provides a structured way to define and handle errors in contracts.

t contains a function named "modexp" that computes the modular exponentiation of a base raised to an exponent modulo a given modulus.

The function takes three parameters: "base" (bytes), "exponent" (bytes), and "modulus" (bytes). It returns a boolean value indicating the success of the computation and the result of the modular exponentiation as bytes.

The function internally encodes the input parameters and calls the modexp precompile contract using inline assembly. The result is stored in the "output" variable.

It provides two functions: "call" and "delegatecall" which are used for making external function calls in a more optimized way. The "call" function is used for making regular calls to other contracts, while the "delegatecall" function is used for making delegate calls. The library also includes a function called "returnData" which is used to retrieve the return data from a previous external call.

In Solidity, a library is a reusable piece of code that defines functions and/or data structures that can be used by other contracts. Libraries are similar to contracts, but they cannot be deployed independently. Instead, they are meant to be used as shared code by other contracts.

It defines several constant variables related to role thresholds. These thresholds determine the number of individuals required to perform certain actions or make certain decisions within a smart contract system.

Here's a breakdown of the defined thresholds:

- `OWNERTHRESHOLD`: This constant represents the number of individuals required to reach a consensus for owner-related actions.
- `OWNERCANCELTIMELOCKTHRESHOLD`: This constant represents the number of individuals required to cancel a timelock for owner-related actions.
- `GUARDIANTHRESHOLD`: This constant represents the number of individuals required to reach a consensus for guardian-related actions.
- `GUARDIANTIMELOCKTHRESHOLD`: This constant represents the number of individuals required to reach a consensus for guardian-related actions that are timelocked.
- `SYNCTXTHRESHOLD`: This constant represents the number of individuals required to synchronize transactions.
- `ASSETSOPTHRESHOLD`: This constant represents the number of individuals required to perform asset-related operations.

These thresholds can be used within a contract system to enforce multi-signature or multi-factor authentication mechanisms for critical actions.

FeeEstimator is used to estimate the fee amount incurred when calling a function on another contract.

The `estimate` function takes several parameters:
- `token`: The address of the token (ERC20) used for the fee. If it is set to `address(0)`, it means the fee is in Ether.
- `feeReceiver`: The address that will receive the fee amount.
- `to`: The address of the contract on which the function will be called.
- `data`: The function call data.

The function first determines the starting balance of the fee receiver before the function call. If the fee is in Ether, it checks the balance of the fee receiver's address. Otherwise, it uses the `balanceOf` function of the ERC20 token to determine the initial balance.

Then, it measures the initial gas remaining before the function call and executes the function call using the provided `to` and `data` parameters.

After the function call, it calculates the gas used by subtracting the remaining gas from the initial gas.

Finally, it calculates the fee amount by comparing the final balance of the fee receiver with the initial balance. If the fee is in Ether, it subtracts the starting balance from the current balance. Otherwise, it uses the `balanceOf` function of the ERC20 token to determine the final balance and subtracts the initial balance.

The function returns a tuple with the following values:
- `success`: A boolean indicating whether the function call was successful.
- `result`: The result of the function call.
- `gas`: The gas used by the function call.
- `feeAmount`: The calculated fee amount.

This contract is called "GasEstimator" and it provides a function called "estimate". 

The "estimate" function takes two parameters: "to" (an address) and "data" (a byte array). It returns a tuple containing three values: "success" (a boolean indicating if the function call was successful), "result" (the result of the function call), and "gas" (the amount of gas used during the function call).

Inside the function, it first records the initial amount of gas using the "gasleft()" function. Then, it calls the "to" address with the provided "data" using the "call" function. After the function call, it calculates the amount of gas used by subtracting the current gas value from the initial gas value.

LibUnipassSig contains functions for parsing and validating various types of signatures used in the Unipass protocol. The library supports three types of key: Secp256k1, ERC1271Wallet, and OpenIDWithEmail. The library also includes functions for sub-digest calculation and key parsing for OpenIDWithEmail signatures.

Solidity contract named "ModuleGuest" is a module that extends the "ModuleTransaction" contract and includes functions for executing transactions.

The contract defines a function called "subDigest" which calculates a digest based on the given parameters. It also includes a function named "execute" which takes an array of transactions as input and executes them.

Within the "execute" function, each transaction in the array is processed sequentially. The gas limit is checked, and if there is not enough gas, an event is emitted or a revert occurs based on the transaction's "revertOnError" flag.

The transaction is then executed using the "LibOptim.call" function, which is a utility for making contract calls. If the transaction is successful, an event is emitted. Otherwise, the contract reverts or returns an error based on the "revertOnError" flag.


Solidity smart contract called ModuleMainGasEstimator is an implementation of several modules such as ModuleIgnoreAuthUpgradable, ModuleAccount, ModuleHooks, ModuleCall, ModuleSource. It also has dependencies on other contracts such as IDkimKeys, IOpenID, and IModuleWhiteList.

The contract has a constructor that takes in several parameters including instances of the dependencies and sets them as immutable variables. It also has a few internal functions that override functions from the implemented modules.

The contract is used for gas estimation purposes and includes functions for updating keyset hash, validating nonces, validating meta nonces, and requiring whitelist checks for hooks and implementations.

### SDK

**Provider**

The class UniPassProvider implements the `IEthereumProvider` interface and provides functionality for interacting with the Ethereum blockchain through the UniPass wallet.

Here are the key features of this class:

- It maintains the current chain ID and account information.
- It uses a `JsonRpcProvider` instance as the signer for sending requests to the Ethereum network.
- It handles various Ethereum provider methods such as `request`, `connect`, `disconnect`, `enable`, and more.
- It emits events using the `EventEmitter` class to notify listeners about changes in connection, chain ID, etc.
- It includes helper methods to check if the provider is a UniPass provider, if it is connected, and to retrieve the current chain ID and signer.

The type.ts file defines several interfaces and types. Here is a breakdown of what each interface represents:

1. `RpcUrls`: This interface defines a set of URLs for different blockchain networks. Each URL is associated with a specific network, such as mainnet, testnet, or a specific chain.

2. `Configurations`: This interface defines optional configurations for the UniPassProvider. It includes a boolean flag `onAuthChain` and a `walletUrl` property of type `WalletURL`.

3. `UniPassProviderOptions`: This interface represents the options for the UniPassProvider. It includes the `chainId` property, which specifies the chain ID for the blockchain network. It also includes a boolean flag `returnEmail` to indicate whether the user's email should be returned. Additionally, it can include optional configurations (`configurations`), app settings (`appSettings`), and RPC URLs (`rpcUrls`).

The TypeScript class JsonRpcProvider is used to interact with a JSON-RPC provider and the UniPassPopupSDK. 

Here is a breakdown of the class:

- The class has several private properties, including `appSetting`, `returnEmail`, `configurations`, `rpcUrls`, `chainId`, `http`, and `upWallet`.
- The constructor takes in parameters such as `chainId`, `returnEmail`, `configurations`, `rpcUrls`, and `appSetting` to initialize the class properties.
- The `connect` method is used to connect to the UniPass wallet and retrieve the connected account. If the account is already connected, it returns the account. Otherwise, it prompts the user to login with their email.
- The `disconnect` method is used to disconnect the UniPass wallet.
- The `request` method handles different JSON-RPC requests. It checks the request method and performs the corresponding action, such as signing typed data, signing a message, sending a transaction, or forwarding the request to the JSON-RPC provider.
- The `updateUpWalletConfig` method is used to update the UniPass wallet configuration based on the provided `chainId`.

**Utility**

The code includes various functions and interfaces related to handling messages and typed data in a popup window. 

Here's a breakdown of the code:

- The code imports necessary modules from packages like `@unipasswallet/popup-types` and `ethers`.
- It defines an interface `TypedData` that represents a typed data object.
- It exports functions like `encodeTypedDataHash`, `encodeTypedDataDigest`, `registerPopupHandler`, `unregisterPopupHandler`, and `postMessage`.
- The `encodeTypedDataHash` function takes a `TypedData` object as input and returns the encoded hash of the typed data.
- The `encodeTypedDataDigest` function takes a `TypedData` object as input and returns the encoded digest of the typed data as a `Uint8Array`.
- The `registerPopupHandler` function registers a message handler for the popup window and sends a 'UP_READY' message to the SDK.
- The `unregisterPopupHandler` function removes the registered message handler.
- The `postMessage` function sends a message to the parent window.

The utility code provides functions for verifying Ethereum account signatures. 

The `verifyMessageSignature` function verifies the signature of a message. It takes the message, signature, account address, and an optional flag indicating whether the personal hash algorithm uses the EIP191 prefix. It returns a promise that resolves to a boolean indicating the signature's validity.

The `verifyTypedDataSignature` function verifies the signature of a typed data message. It takes the typed data, signature, account address, and an optional provider for contract signature validation. It returns a promise that resolves to a boolean indicating the signature's validity.

The `UniPassHashMessage` function generates the hash of a message using the UniPass Signed Message prefix.

The `checkWalletSignature` function checks the signature of a message against an account address. It first tries to recover the address from the signature and compares it to the provided address. If they match, it returns true. Otherwise, it calls the `checkContractWalletSignature` function to perform contract signature validation.

The `checkContractWalletSignature` function checks the signature of a message against a contract address using the EIP1271 ABI. It returns a promise that resolves to a boolean indicating the signature's validity.

**Types**

The code snippet defines various types and classes related to a user authentication and authorization system called UniPass. Here's a breakdown of the code:

- The `Environment` type defines two possible values: 'test' and 'prod', representing different environments.
- The `ChainType` type defines several possible blockchain types.
- The `UPMessageType` type defines different message types that can be sent within the UniPass system.
- The `UPAccount` class represents a user account and its associated properties.
- The `UPEventType` enum defines a single event type called 'REGISTER'.
- The `UPEvent` class represents an event within the UniPass system, with a type and a body (UPAccount).
- The `UPEventListener` type is a function type that takes a UPEvent as a parameter and returns void.
- The `UPAuthMessage` class represents an authentication message with various properties.
- The `UPTransactionMessage` class represents a transaction message with properties such as sender, recipient, value, and data.
- The `UPResponse` class represents a response message with a type ('APPROVE' or 'DECLINE') and data (UPAccount or string).
- The `AppSettings` type represents settings for a UniPass app, including the blockchain chain, app name, app icon, and theme.
- The `UPMessage` class represents a message within the UniPass system, with a type, payload, and app settings.
- The `UniPassTheme` enum defines two theme options: 'LIGHT' and 'DARK'.
- The `ConnectType` type defines different types of connections (e.g., 'google', 'email', 'both').
- The `UPConnectOptions` type represents options for connecting to UniPass, including email, connect type, authorization, force login, and event listener.
- The `MessageTypeProperty` interface represents a property of a message type, with a name and type.
- The `MessageTypes` interface defines the structure of different message types, including the EIP712Domain type and additional properties.
- The `TypedMessage` interface represents a typed message with types, primary type, domain, and message properties.

**Authorize**

The "authorize" function takes in two parameters: "message" of type UPAuthMessage and "config" of type PopupSDKConfig.

Inside the function, it first retrieves the session account from storage using the "useStorage" function and the "UPA_SESSION_KEY" constant. It checks if there is a session account and if the "from" property of the message matches the address of the session account. If not, it throws an error indicating that authorization cannot be done without login.

Next, it creates a new UPMessage object with the type "UP_SIGN_MESSAGE", the serialized "message" parameter, and the "appSettings" property from the "config" parameter.

Then, it tries to execute the "execPop" function with the created message and awaits the response. If successful, it returns the response as a string. If there is an error, it throws an error with the error message.

**Bridge**

The code handles communication between a web page and a browser extension called "UniPass Wallet". The function is named `execPop` and it takes several parameters:

- `message`: This is an object that represents the message being sent to the browser extension.
- `connectType`: This parameter specifies the type of connection to be established with the browser extension.
- `forceLogin`: A boolean value indicating whether the user should be forced to login.
- `listener`: An event listener function that will be called when a message is received from the browser extension.

The function returns a Promise that resolves when an "APPROVE" response is received from the browser extension, and rejects when a "DECLINE" response is received or when an error occurs.

Inside the function, there is a call to the `pop` function, which is not included in the code snippet you provided. This function is responsible for establishing a connection with the browser extension and managing the communication.

The `onReady` callback is called when the connection is established and ready to send messages to the browser extension. It sends the initial message.

The `onResponse` callback is called when a response is received from the browser extension. It parses the response and handles different cases based on the response type. If the response type is "APPROVE", the Promise is resolved with the response data and the connection is closed. If the response type is "DECLINE", the Promise is rejected with the response data. If the response data is "expired", it handles different cases based on the message type. If the message type is "UP_LOGIN", it does nothing. If the message type is "UP_LOGOUT", the Promise is resolved with the response data and the connection is closed. If the message type is "UP_TRANSACTION" or "UP_SIGN_MESSAGE", it disconnects from the browser extension, rejects the Promise with an error message, and closes the connection.

The `onMessage` callback is called when a message is received from the browser extension. It parses the message and calls the `listener` function if it is provided.

The `onClose` callback is called when the connection is closed externally. It rejects the Promise with an error message.

**Config**

This module exports various functions and types related to the UniPass wallet SDK. Here is a brief overview of the code:

- The module exports an interface `UP_API_CONFIG` and a function `WalletURL` for configuring the UniPass wallet API URLs.
- The `config` variable holds the default configuration for the UniPass wallet API URLs.
- The `getConfig` function returns the current configuration.
- The module also exports types `StorageType` and `PopupSDKConfig` for configuring the UniPass wallet SDK.
- Constants `TEST_WALLET_URL` and `MAIN_WALLET_URL` define the URLs for the testnet and mainnet wallets respectively.
- The `NODE_RPC_LIST` object holds the RPC URLs for different chains on the testnet and mainnet.
- The `getDefaultConfigOption` function returns the default configuration options based on the environment and chain type.
- The `getAppSettings` function returns the app settings for the UniPass wallet SDK.
- The `getAuthProviderUrl` function returns the RPC URL for the Polygon chain based on the environment.
- The `PopupSDKOption` type defines the configuration options for the UniPass wallet SDK.

**Connect**

This module contains functions related to connecting, disconnecting, and retrieving account information for a Unipass Wallet popup SDK.

Here is a breakdown of the functions:

1. `connect`: This function is used to establish a connection with the Unipass Wallet. It takes a configuration object (`config`) and an optional `options` object. It returns a promise that resolves to a `UPAccount` object.

2. `getLocalAccount`: This function retrieves the locally stored account information from the specified storage type (`localStorage` or `sessionStorage`). It returns a `UPAccount` object if available, otherwise `undefined`.

3. `disconnect`: This function is used to disconnect from the Unipass Wallet. It takes a boolean parameter `deep` which determines whether to perform a deep logout. If `deep` is `true`, it sends a logout message to the wallet using `execPop`. It also removes the account information from both `localStorage` and `sessionStorage`.

4. `getAccount`: This function is responsible for retrieving the account information from the Unipass Wallet. It takes a configuration object (`config`) and an optional `options` object. It returns a promise that resolves to a `UPAccount` object. It sends a login message to the wallet using `execPop` and stores the account information in the specified storage type.

**Core**

The code defines a class called `UniPassPopupSDK` which provides various methods for interacting with UniPass, such as login, logout, sending transactions, signing messages, and verifying signatures. It also includes helper functions for hashing messages and getting the user's asset contract address.

The class uses the `@ethersproject/providers` library for interacting with Ethereum JSON-RPC providers, and other libraries like `@unipasswallet/popup-types` and `@unipasswallet/popup-utils` for UniPass-specific functionality.

**Pop**

The `pop` function is used to open a popup window and communicate with it using the `window.postMessage` API.

The `pop` function takes several parameters:

- `message`: An object of type `UPMessage` that represents the initial message to be sent to the popup window.
- `connectType`: An optional parameter of type `ConnectType` that specifies the type of connection to be used (e.g., 'google', 'email').
- `forceLogin`: An optional boolean parameter that indicates whether to force the user to log in again.
- `opts`: An optional object that contains callback functions for various events (e.g., `onClose`, `onMessage`, `onReady`, `onResponse`).

The `pop` function returns an object with two functions: `send` and `close`. The `send` function is used to send messages to the popup window, while the `close` function is used to close the popup window.

The `pop` function also defines several helper functions and constants, such as `serviceEndPoint`, which constructs the URL for various types of services based on the provided parameters.

**Storage**

This module defines a custom hook called `useStorage`. The hook allows you to interact with either `localStorage` or `sessionStorage` based on the `storageType` parameter passed to it.

The `useStorage` hook initializes a variable `_storage` based on the `storageType` value. If `storageType` is set to `'localStorage'`, it assigns `window.localStorage` or `localStorage` to `_storage`. Otherwise, if it is set to any other value, it assigns `window.sessionStorage` or `sessionStorage` to `_storage`.

The hook then defines three functions: `get`, `set`, and `remove`. These functions allow you to interact with the chosen storage type. 

- The `get` function retrieves the value associated with a given `key` from the storage and returns it. If the value does not exist, it returns an empty string.
- The `set` function sets the value of a given `key` in the storage to the provided `value`. If `value` is empty, it sets an empty string.
- The `remove` function removes the entry associated with a given `key` from the storage.


