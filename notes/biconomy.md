# Smart Account 

The Biconomy Smart Accounts are signer agnostic, which allows you to use any authorization package of your choice as long as you can pass a signer to our SDK upon the creation of a Smart Account.

Biconomy offers a Paymaster service designed with one of the best developer experiences in mind. Simply use one URL and switch modes between our sponsorship paymaster and our Token Paymaster.

The Bundler is a service that tracks userOps that exist in an alternative mem pool and as the name suggests, bundles them together to send to an Entry Point Contract for eventual execution onchain.

Building and sending UserOperations is a key offering of any toolkit designed for ERC4337. The Biconomy account package stands as an exemplary toolkit in this regard. Meticulously crafted with developers' needs in mind, this package seamlessly integrates the essential features associated with ERC-4337. It simplifies the process of creating and sending UserOperations, thus optimizing the development and management of decentralized applications (dApps).

The Biconomy account package achieves this by providing a comprehensive set of methods that enable developers to effortlessly create UserOperations. Combined with the sophisticated backend infrastructure of the Biconomy platform, it ensures efficient and reliable transmission of these operations across EVM networks.

### Solidity Contract

**Proxy**

The Solidity contract Proxy is a basic proxy contract that delegates all calls to a fixed implementation contract. The implementation address is stored in the slot defined by the Proxy's address.

The contract has a constructor that takes an implementation address as a parameter. It checks if the implementation address is valid (not equal to address(0)) and stores it in the contract's storage using the assembly code.

The contract also has a fallback function that is triggered when a function is called on the contract that does not exist. Inside the fallback function, it retrieves the implementation address from storage and uses delegatecall to execute the function on the implementation contract. It also handles the return data and reverts if the delegatecall fails.

**SmartAccount**

A Smart Account is a modular and extensible contract wallet that allows users to manage assets, execute transactions, and interact with other contracts.

Here are some key features of the Smart Account contract:

- It is modular by nature, allowing for the addition and management of various modules such as Social Recovery, Session Key, and others.
- It provides functionality to execute AA (EIP-4337) user operations. User operations and transaction validations are handled by Authorization Modules.
- It allows for the reception and management of assets.
- It manages modules and fallbacks.
- It supports the deposit and withdrawal of native tokens.

The contract includes various functions such as `init` for initializing the Smart Account, `execute` for executing a transaction, `enableModule` for enabling a module, `setFallbackHandler` for setting the fallback handler, and more.

**Interfaces**

An interface for signature validation includes a constant `EIP1271_MAGIC_VALUE` which represents the magic value that should be returned when the signature is valid. The `isValidSignature` function is a view function that takes a data hash and a signature as parameters and returns the magic value if the signature is valid. This function should not modify the contract's state and should allow external calls.

The interface ISessionKeyManager defines a function called "validateSessionKey" which is used to validate a session key and its parameters.

The function takes several parameters:
- "userOpSender" is the smart account for which the session key is being validated.
- "validUntil" is a timestamp indicating when the session key expires.
- "validAfter" is a timestamp indicating when the session key becomes valid.
- "sessionValidationModule" is the address of the Session Validation Module.
- "sessionKeyData" is the session parameters (limitations/permissions) encoded as bytes.
- "merkleProof" is an array of bytes32 values representing the merkle proof for the leaf which represents this session key and its parameters.

If the function is called and does not revert, it means that the session key is considered valid.

The authorization interface includes a function called `validateUserOp` which takes two parameters: a `UserOperation` struct and a `userOpHash` of type `bytes32`. The function returns a `uint256` value representing validation data.

The `UserOperation` struct is likely defined in the `@account-abstraction/contracts/interfaces/UserOperation.sol` file, which is imported at the beginning of the contract.

The purpose of this interface is to provide a way for modules to verify signatures that are signed over a `userOpHash`. The specific implementation of the `validateUserOp` function would depend on the requirements of the authorization module.

**Abstract Contracts**

The executor is an abstract contract that can execute transactions. It contains a function named "execute" which takes in parameters such as the destination address, value, data, operation type, and gas limit. The function uses assembly code to execute the transaction either through a delegate call or a regular call. It emits events to indicate the success or failure of the execution.

The ModuleManager is a contract that manages modules that can execute transactions on behalf of a Smart Account. The contract allows for enabling and disabling modules, executing transactions from modules, and retrieving information about the modules.

The FallbackManager is an abstract contract that manages fallback calls made to the Smart Account. Fallback calls are handled by a `handler` contract that is stored at the `FALLBACK_HANDLER_STORAGE_SLOT`. Fallback calls are not delegated to the `handler`, so they cannot directly change the Smart Account storage.

The contract inherits from the "SelfAuthorized" contract and uses the "FallbackManagerErrors" library for error handling. It defines a constant `FALLBACK_HANDLER_STORAGE_SLOT` which is the keccak-256 hash of "fallback_manager.handler.address" subtracted by 1.

The contract includes a fallback function that is triggered when a fallback call is made to the contract. Inside the fallback function, it retrieves the `handler` address from storage and if it is zero, the function returns. Otherwise, it copies the calldata and appends the caller's address to it. Then, it calls the `handler` contract with the modified calldata. If the call is successful, it returns the returndata. If the call fails, it reverts with the returndata.

The contract also includes functions to set and get the fallback handler. The `setFallbackHandler` function allows adding a contract to handle fallback calls, and the `getFallbackHandler` function retrieves the current fallback handler address.

**Delpoyer**

The Deployer imports the "Create3" contract and provides two functions.

1. The `deploy` function takes a salt and creation code as parameters and deploys a contract using the `create3` function from the Create3 contract. It emits an event with the address of the deployed contract.

2. The `addressOf` function takes a salt as a parameter and returns the address of the contract that would be deployed using the given salt.

The Create3 is used for deploying contracts using the EIP-3171 style. This library allows you to create a new contract with a given creation code and salt. It also provides functions to compute the resulting address of a deployed contract and check the size of the code on a given address.

**Factory**

The SmartAccountFactory is responsible for deploying Smart Accounts using CREATE2 and CREATE. The purpose of this contract is to deploy Smart Accounts as proxies pointing to a basic implementation that is immutable. This allows keeping the same address for the same Smart Account owner on various chains via CREATE2.

The contract has functions such as `getAddressForCounterFactualAccount`, `deployCounterFactualAccount`, and `deployAccount` that facilitate the deployment of Smart Accounts. It also has an event `AccountCreation` that is emitted when a new account is created.

The contract inherits from `Stakeable` and has a `basicImplementation` and `minimalHandler` as immutable variables.

**Callback**

The DefaultCallbackHandler implements several interfaces including IERC1155TokenReceiver, IERC777TokensRecipient, IERC721TokenReceiver, and IERC165.

The contract is designed to handle token callbacks and EIP-1271 compliant isValidSignature requests. It provides functions to receive ERC1155, ERC721, and ERC777 tokens, and returns the appropriate selector for each token type.

The supportsInterface function checks if the contract supports a specific interface by comparing the provided interfaceId with the interface IDs of the supported interfaces.

**Module**

Smart Contract Ownership Registry module allows for the validation of user operations signed by other smart contracts using the EIP-1271 standard.

The main functionalities of the contract include:
- Initializing the module for a Smart Account and setting the owner.
- Transferring ownership of a Smart Account.
- Renouncing ownership of a Smart Account.
- Retrieving the owner of a Smart Account.
- Validating user operations by verifying the signature.
- Validating signatures for messages signed by a specific address.

The contract also includes some error handling and events for ownership transfers.

The ECDSA ownership authorization module allows for the validation of user operations signed by an EOA private key and ensures that the Smart Account can validate signed messages. It supports one owner per Smart Account and does not support outdated eth_sign flow for cheaper validations. The contract is EIP-1271 compatible and only supports EOA owners, not Smart Contract Owners. It allows for the initialization and transfer of ownership for a Smart Account and emits an event when ownership is transferred.

### SDK

**Account**

The ISmartAccount interface has four methods:

1. `getSmartAccountAddress(_accountIndex: number): Promise<string>`: This method takes an account index as a parameter and returns a promise that resolves to a string representing the smart account address.

2. `signUserOp(_userOp: UserOperation): Promise<UserOperation>`: This method takes a `UserOperation` object as a parameter and returns a promise that resolves to a signed `UserOperation`.

3. `sendUserOp(_userOp: UserOperation): Promise<UserOpResponse>`: This method takes a `UserOperation` object as a parameter and returns a promise that resolves to a `UserOpResponse` object representing the response of sending the `UserOperation`.

4. `sendSignedUserOp(_userOp: UserOperation): Promise<UserOpResponse>`: This method takes a signed `UserOperation` object as a parameter and returns a promise that resolves to a `UserOpResponse` object representing the response of sending the signed `UserOperation`.

`INon4337Account` interface defines the methods that a Smart Contract Wallet (also known as Smart Account) should implement. It includes the following methods:

- `estimateCreationGas(_initCode: string)`: Returns the estimated gas required to create the smart contract wallet.
- `getNonce()`: Returns the current nonce of the smart contract wallet.
- `signMessage(_message: Bytes | string)`: Signs a message using the smart contract wallet's private key.
- `getAccountAddress(_accountIndex?: number)`: Returns the address of the smart contract wallet.

`IBaseSmartAccount` interface extends `INon4337Account` and adds additional methods specific to a base smart account. It includes the following methods:

- `getVerificationGasLimit(_initCode: BytesLike)`: Returns the gas limit required for verification of a specific initialization code.
- `getPreVerificationGas(_userOp: Partial<UserOperation>)`: Returns the gas required for pre-verification of a user operation.
- `signUserOp(_userOp: UserOperation)`: Signs a user operation.
- `signUserOpHash(_userOpHash: string)`: Signs a user operation hash.
- `getUserOpHash(_userOp: Partial<UserOperation>)`: Returns the hash of a user operation.
- `getAccountInitCode()`: Returns the initialization code of the smart contract wallet.
- `getDummySignature()`: Returns a dummy signature.

The interface IBiconomySmartAccount includes various methods and properties related to interacting with Biconomy's smart accounts. The interface extends another interface called ISmartAccount and defines additional methods such as initialization, executing calls, getting token balances, getting transaction details, and more. It also includes methods for attaching a signer and retrieving supported chains.

The class BaseSmartAccount is an abstract class that provides a base implementation for a smart account. Some of the key functionalities provided by this class include:

- Initializing the smart account with the necessary configuration parameters such as the entry point address, account address, paymaster, bundler, chain ID, and provider.
- Validating and signing user operations.
- Sending user operations to the bundler for execution.
- Estimating gas values for user operations.
- Handling contract deployment and verification.
- Retrieving account addresses and transaction receipts.

The SmartAccount class provides various methods and functionality related to smart contract operations. It includes functions for estimating gas values, signing user operations, sending user operations to a bundler, and more.

The class has several dependencies and uses various interfaces and types from external libraries. It also includes abstract methods that need to be implemented in child classes.

**Particle Auth**

Particle Network leverages secure multiparty computation (MPC) for the protection and management of cryptographic keys and secrets, providing industry-grade MPC-based solutions for key management and protection. Sensitive keys and secrets are split into two random shares. The two shares are stored on separate, segregated parties. Each share reveals nothing about the key material. The Threshold Signature Scheme (TSS) is a cryptographic primitive for distributed key generation and signing. When signing transactions, we run a distributed signature generation between two parties. 

**Web3 Auth**

The component is called "UI" and It includes various elements such as social login buttons, an email login form, and options for external wallet login using MetaMask or Wallet Connect. The component receives a prop called "socialLogin" which is an instance of the "SocialLogin" class. The component also uses React hooks, specifically the useState hook, to manage the state of the email input field.

Social Login SDK includes imports for various libraries and modules related to authentication, such as React, ethers, and web3auth. The code defines a class called SocialLogin, which provides methods for initializing the SDK, handling user authentication, and retrieving user information.

The class includes methods for interacting with different wallet adapters, such as Openlogin, Metamask, and WalletConnect. It also provides methods for showing and hiding the login modal, retrieving user information, and logging out.

Additionally, the code exports an instance of the SocialLogin class as well as a function for getting the initialized instance of the SDK.


