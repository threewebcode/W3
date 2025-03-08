# Cyber Connect

### Code Navigation

The contract ABI is represented as constant variable. The collect of contracts are account, bundler, factory, token, entry point. The index.ts file is served as the main file of the whole package. The viem library is depended in this project. The basic items are imported from the view library. Each contract has its own class to make the operations in its own module file. The types are defined in the separate file. The CyberAccount class combines different pieces together and acts as the facet. 

As for a contract, the client should be created with the chain configuration. The client is used to send the requests with appropriate parameters. The parameter type is mapped by the RPC method name. The factory pattern is adopted to create the contract account. 

TypeScript code defining various types and interfaces related to a bundler and paymaster system. It includes types for user operations, transaction data, estimated gas values, bundler RPC requests, user operation receipts, estimation values, bundler actions, bundler clients, paymaster data, paymaster context, estimated user operation return, sponsor user operation return, user operation status, pending user operation, paymaster RPC requests, paymaster actions, paymaster clients, on-chain user operation, and top-up contract request. These types and interfaces likely serve as a foundation for implementing the bundler and paymaster functionalities in a decentralized application.

The file suffix is tsx and it is extended ts syntax. The user interface component is defined by constant variable and exported for external usage. The function type is passed and generic type is specified. The default page is the page.tsx file. In this file, the home component is defined. The home component is function type component. The SDK and viem packages are imported to take part in the home functionalities. The cyber app from the SDK package is created and set as the home state. The app instance is utilized to make the blockchain network operation.

The component initializes a CyberApp instance and connects to it. It also creates a wallet client using the `createWalletClient` function from the "viem" library. The user can enter the transaction details (amount and recipient address) and choose to send the transaction either via CyberWallet or MetaMask.

If the user chooses to send the transaction via CyberWallet, the `sendViaCyberWallet` function is called, which sends the transaction using the `optimismGoerli.sendTransaction` method of the CyberWallet. If the user chooses to send the transaction via MetaMask, the `sendViaMetaMask` function is called, which sends the transaction using the `sendTransaction` method of the wallet client.

It defines schemas for user operations, RPC contexts, and contract calls, as well as type definitions for return values of different RPC methods.

The module also exports a `CyberConnectClient` type, which represents a client for interacting with the CyberConnect API. It includes methods for estimating transactions, sponsoring user operations, sending user operations, and retrieving user operations by hash.

Additionally, the module exports `UserOperationSchema` and `UnsignedUserOperationSchema`, which are Zod schemas for validating user operation objects.

### Chain

This is a TypeScript class called "Chain" that represents a blockchain network. It has properties such as "id", "sendTransactionBase", and "cyberAccount". The "id" represents the unique identifier of the chain, "sendTransactionBase" is a function used to send transactions on the chain, and "cyberAccount" is an instance of the "CyberAccount" class associated with the chain.

The class has a constructor that takes an object with "id" and "sendTransaction" properties as parameters. It initializes the "id" and "sendTransactionBase" properties with the provided values.

The class also has a method called "setCyberAccount" that takes a "cyberAccount" parameter of type "CyberAccount" or null. This method sets the "cyberAccount" property of the class.

Another method in the class is "sendTransaction", which takes a "transaction" parameter of type "WalletTransaction" and an optional "option" parameter. Inside this method, it checks if a "cyberAccount" is set. If not, it returns without performing any action. If a "cyberAccount" is set, it calls the "sendTransactionBase" function with the provided transaction details and the chain's ID and owner address. It also passes the optional "option" parameter. The method returns the result of the "sendTransactionBase" function.

Finally, the "Chain" class is exported as the default export of the module.

### Cyber Account

TypeScript class definition for a `CyberAccount` object. It imports the `Address` type from a file called "types". The `CyberAccount` class has two properties: `address` and `ownerAddress`, both of type `Address`. It also has a constructor that takes an object with `address` and `ownerAddress` as parameters and assigns them to the corresponding properties of the class instance. Finally, the class is exported as the default export of the module.

### Cyber App

TypeScript class called "CyberApp". It represents a cyber application and has properties such as "name", "cyberWallet", "messenger", and "icon". It also has a constructor that initializes these properties based on the provided "AppInfo". The class has methods like "start" and "connect" which are used to initiate the connection with the cyber wallet and return a cyber account. The "start" method is an async function that calls the "connect" method internally. The "connect" method sends a message to the messenger to connect with the cyber wallet and returns a promise that resolves with the cyber account when the connection is successful.

### Cyber Wallet

TypeScript class called "CyberWallet". It is used to create a wallet object that interacts with various blockchain networks. Here are some key points about the class:

- It imports several types and classes from other files, including "./types", "./Messenger", "./CyberAccount", "./Chain", and "./config/chains".
- The class has a constructor that takes in a context window and an appInfo object as parameters.
- The class has properties such as "contextWindow" (the window object), "connected" (a boolean indicating if the wallet is connected), "messenger" (an instance of the Messenger class), and "cyberAccount" (an instance of the CyberAccount class or null).
- The class has properties for different supported chains, such as "optimism", "polygon", "arbitrum", etc. Each chain is an instance of the Chain class and has a unique ID and a "sendTransaction" method.
- The class has methods like "setConnection" to set the connection status, "setCyberAccount" to set the CyberAccount instance, and "sendTransaction" to send a transaction to the blockchain network.
- The "sendTransaction" method sends a message to the Messenger instance with the transaction details and returns a promise that resolves or rejects based on the response received from the Messenger.

Overall, the CyberWallet class provides a way to interact with different blockchain networks and perform transactions.


