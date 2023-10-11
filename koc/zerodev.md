# ZeroDev Account Abstraction

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


