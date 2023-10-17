# ZeroDev Account Abstraction

### Basic Principle

Signers are objects that can sign transactions. In the case of a ECDSA validator, only one signer is needed, but other validators could require more than one signers, such as a multisig validator.

One common misunderstanding of AA wallets is that they are inherently non-custodial. In fact, whether a wallet is custodial or not has nothing to do with whether it's AA -- it's the signer that determines whether the wallet is custodial. If only the user controls their signer, then the wallet can be said as non-custodial. If the signer is controlled by a third party, then the wallet would be custodial.

ZeroDev has support for many signers such as passkeys, social accounts, EOAs, raw private keys, as well as a large number of third-party signer integrations so you can use ZeroDev with popular Wallet-as-a-Service (WaaS) offerings such as Magic and Web3Auth.

Verifying paymaster: this paymaster pays gas if it can verify that the transaction has been approved by the operator of the paymaster. Presumably, the operator pays for the transaction due to some off-chain arrangements. With ZeroDev, we let you use the verifying paymaster to sponsor gas for your users.

ERC20 paymaster: this paymaster pays gas for a transaction in exchange for ERC20 tokens (such as USDC), thus effectively enabling the user to pay gas with ERC20 tokens.

Note that the very nature of account abstraction means that different AA accounts may implement different signing schemes.

While Kernel is compatible in principle with any account abstraction (AA) system, it's primarily designed to work with ERC-4337. To understand how Kernel works, let's look at the lifecycle of a ERC-4337 transaction processed by Kernel.

In ERC-4337, there is a global EntryPoint contract that invokes smart contract accounts to process transactions. To differentiate between regular transactions and AA transactions, we call the AA transactions "user operations," or "UserOps" for short.

A UserOp is processed in two phases: a "validation phase" and an "execution phase." Correspondingly, Kernel also supports two types of plugins: "validators" and "executors."

ZeroDev uses a unique "meta infrastructure" -- we work with various bundler/paymaster providers and shard the traffic among them. Critically, ZeroDev has developed a transparent fallback mechanism, so that when one bundler or paymaster fails, we transparently fail over to another provider, so the end user doesn't notice any downtime.

### Code Implementation

**Kernal**

It is a wallet kernel for extensible wallet functionality. The contract includes functions for executing external contract calls, validating user operations, and checking the validity of signatures. It also includes various import statements for external libraries and contracts.

The Kernel contract inherits from several other contracts such as EIP712, Compatibility, KernelStorage, and KernelHelper. It also defines some constants and error messages.

**Interfaces**

Kernel Validator contract defines several functions that can be called on the contract:

1. `enable`: This function enables a new validator for a given action and uses it for the current user operation.

2. `disable`: This function disables a validator for a given action.

3. `validateUserOp`: This function validates a user operation by checking if it meets certain criteria. It takes a `UserOperation` struct, a user operation hash, and the amount of missing funds as input parameters. It returns a `ValidationData` struct.

4. `validateSignature`: This function validates a signature by checking if it matches a given hash. It takes a hash and a signature as input parameters and returns a `ValidationData` struct.

5. `validCaller`: This function checks if the caller of the contract is valid for a given data. It takes the caller's address and the data as input parameters and returns a boolean value indicating whether the caller is valid.

The code also mentions three modes that can be used with the Kernel Validator contract:

1. Default mode: This is the default mode where a preset validator is used for the kernel.

2. Enable mode: This mode enables a new validator for a specific action and uses it for the current user operation.

3. Sudo mode: This mode uses the default plugin for the current user operation.

**Abstract Contracts**

Solidity contract KernelStorage serves as the storage module for the Kernel contract. It includes various functions and events related to contract initialization, upgrades, execution details, default validator, disabled mode, and more. It also includes modifiers to restrict access to certain functions.

It includes three external functions: `onERC721Received`, `onERC1155Received`, and `onERC1155BatchReceived`. These functions define how the contract handles receiving ERC721 and ERC1155 tokens.

The `receive` function is a fallback function that allows the contract to receive Ether when it is sent to it.

The `onERC721Received` function takes in the sender's address, token address, token ID, and additional data as parameters. It returns a bytes4 value that represents the function selector.

The `onERC1155Received` function takes in the sender's address, token address, token ID, token amount, and additional data as parameters. It also returns a bytes4 value representing the function selector.

The `onERC1155BatchReceived` function is similar to `onERC1155Received`, but it takes in arrays of token IDs and amounts instead of single values.

This abstract contract can be inherited by other contracts that want to implement these token receiving functions.

**Executor**

TokenActions defines three functions for transferring different types of tokens.

1. The "transfer20Action" function allows for transferring ERC20 tokens. It takes three parameters: the token address, the amount to transfer, and the recipient's address. It uses the "transfer" function from the IERC20 interface to transfer the specified amount of tokens from the contract to the recipient.

2. The "transferERC721Action" function allows for transferring ERC721 tokens. It takes three parameters: the token address, the token ID to transfer, and the recipient's address. It uses the "transferFrom" function from the IERC721 interface to transfer the specified token from the contract to the recipient.

3. The "transferERC1155Action" function allows for transferring ERC1155 tokens. It takes five parameters: the token address, the token ID to transfer, the recipient's address, the amount to transfer, and additional data. It uses the "safeTransferFrom" function from the IERC1155 interface to transfer the specified amount of tokens from the contract to the recipient, along with any additional data.

**Factory**

The KernelFactory is used to create instances of a contract called "Kernel" and manage their deployments. The contract inherits from "AdminLessERC1967Factory" and "Ownable" contracts.

Here are the main functionalities of the contract:

1. It allows the owner to set the implementation contract address and specify whether it is allowed or not.
2. It allows the owner to set the entry point contract address.
3. It provides a function to create an account by deploying a deterministic proxy contract using the specified implementation, data, and index.
4. It provides a function to get the account address based on the provided data and index.
5. It provides functions related to staking, such as adding stake, unlocking stake, and withdrawing stake.


