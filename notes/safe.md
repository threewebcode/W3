# Safe Smart Account

Uses a multi-signature logic where a threshold of owners must confirm a transaction before execution to provide a secure default without trusting any additional contract.

At the heart of the protocol is the Manager, ensuring adherence to the prescribed rules set by the Registry. The Manager is an intermediary layer coordinating communication and interactions between Accounts and Modules.

Accounts are smart-contract-based user accounts (or Smart Accounts). The Safe{Core} Protocol is account-agnostic, meaning it is not tied to a specific account implementation.

Modules extend the functionality of Accounts in different ways. Initial Modules are Plugins, Hooks, Function Handlers, and Signature Verifiers.

The Registry is critical in maintaining and enforcing standards and security guarantees. The Manager will recognize and manage only the Modules that adhere to these guidelines.

Giving Metadata is crucial to offer a coherent context to the various parts and their interactions. This information helps developers add context to interactions, enhancing user understanding and transparency.

The Auth Kit creates externally-owned accounts and authenticates them using an email address, a social media account or another crypto wallet account.

The Auth Kit creates an Ethereum address and authenticates a blockchain account using an email address, social media account, or traditional crypto wallets like Metamask. You can obtain the ethereum address and the associated safe addresses as an output for the sign in process.


