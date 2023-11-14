# Bitcoin

### Develop Guide

**Transaction**

Each transaction has at least one input and one output. Each input spends the satoshis paid to a previous output. Each output then waits as an Unspent Transaction Output (UTXO) until a later input spends it. When your Bitcoin wallet tells you that you have a 10,000 satoshi balance, it really means that you have 10,000 satoshis waiting in one or more UTXOs.

An output has an implied index number based on its location in the transaction—the index of the first output is zero. The output also has an amount in satoshis which it pays to a conditional pubkey script. Anyone who can satisfy the conditions of that pubkey script can spend up to the amount of satoshis paid to it.

An input uses a transaction identifier (txid) and an output index number (often called “vout” for output vector) to identify a particular output to be spent. It also has a signature script which allows it to provide data parameters that satisfy the conditionals in the pubkey script.

Pubkey scripts and signature scripts combine secp256k1 pubkeys and signatures with conditional logic, creating a programmable authorization mechanism.

The validation procedure requires evaluation of the signature script and pubkey script. The spender’s signature script is evaluated and prefixed to the beginning of the script. To test whether the transaction is valid, signature script and pubkey script operations are executed one item at a time.

Pubkey scripts are created by spenders who have little interest what that script does. Receivers do care about the script conditions and, if they want, they can ask spenders to use a particular pubkey script. To solve these problems, pay-to-script-hash (P2SH) transactions were created in 2012 to let a spender create a pubkey script containing a hash of a second script, the redeem script. 

**Locktime and Sequence Number**

The locktime indicates the earliest time a transaction can be added to the block chain. Locktime allows signers to create time-locked transactions which will only become valid in the future, giving the signers a chance to change their minds. f any of the signers change their mind, they can create a new non-locktime transaction. The new transaction will use, as one of its inputs, one of the same outputs which was used as an input to the locktime transaction. This makes the locktime transaction invalid if the new transaction is added to the block chain before the time lock expires. 

Sequence numbers were meant to allow multiple signers to agree to update a transaction; when they finished updating the transaction, they could agree to set every input’s sequence number to the four-byte unsigned maximum (0xffffffff), allowing the transaction to be added to a block even if its time lock had not expired.

**Wallet**

Three necessary, but separable, parts of a wallet system: a public key distribution program, a signing program, and a networked program. The simplest wallet is a program which performs all three functions: it generates private keys, derives the corresponding public keys, helps distribute those public keys as necessary, monitors for outputs spent to those public keys, creates and signs transactions spending those outputs, and broadcasts the signed transactions. To increase security, private keys can be generated and stored by a separate wallet program operating in a more secure environment. These signing-only wallets work in conjunction with a networked wallet which interacts with the peer-to-peer network.

### Inheritance

Bitcoin Cash: Bitcoin Cash is a fork of Bitcoin that was created in 2017. It was created to address some of the scalability issues of Bitcoin by increasing the block size limit from 1 MB to 8 MB.

Bitcoin SV: Bitcoin SV is a fork of Bitcoin Cash that was created in 2018. It was created to restore the original vision of Bitcoin as outlined in the Bitcoin whitepaper.

### Advancement

Lightning Network: The Lightning Network is a layer 2 scaling solution for Bitcoin that allows for faster and cheaper transactions. It works by creating payment channels between users, which can be used to send and receive Bitcoin without having to wait for confirmations on the blockchain.

Segregated Witness: Segregated Witness, or SegWit, is a soft fork that was activated in 2017. It separates the digital signature from the transaction data, which allows for more transactions to be included in each block and reduces transaction fees.

Taproot: Taproot is a proposed soft fork that is currently being developed. It aims to improve privacy and scalability by allowing for more complex smart contracts to be executed off-chain.

### Scaling

Lightning Network: Lightning Network is a layer 2 scaling solution for Bitcoin that allows for faster and cheaper transactions. It works by creating payment channels between users, which can be used to send and receive Bitcoin without having to wait for confirmations on the blockchain. Binance, the largest exchange in the world, has already integrated Lightning Network for BTC withdrawals and deposits.

Rootstock: Rootstock is a smart contract platform that is built on top of the Bitcoin blockchain. It allows for the creation of decentralized applications (DApps) and smart contracts, which can be executed off-chain to improve scalability.

Stacks: Stacks is a layer 2 scaling solution that allows for the creation of smart contracts on the Bitcoin blockchain. It uses a unique consensus mechanism called Proof of Transfer (PoX) to secure the network and enable cross-chain interoperability.

Liquid Network: Liquid Network is a sidechain that is built on top of the Bitcoin blockchain. It allows for faster and more confidential transactions between exchanges and other large Bitcoin holders.

Rollups: Rollups are a type of layer 2 scaling solution that bundle multiple transactions together and process them off-chain. There are two types of rollups: validity rollups and optimistic rollups. Validity rollups are more secure but require more on-chain data, while optimistic rollups are less secure but require less on-chain data.

### Scripting

The scripting language is made up of a set of 186 opcodes which each conduct operations on the processing stack. Any node that wishes to process transactions on the Bitcoin network must ensure that their node client implementation is processing each of the opcodes in a way that exactly matches the outcomes expected by every other node on the network at that time, including whether or not those opcodes are enabled or not.

All data items in Bitcoin Script are a byte sequence. Some operations interpret their parameters as numeric or boolean values and require the item to fulfil the specifications of those types. Some operations produce items on the stack which are valid numeric or boolean values.

The complete script consists of two sections, the unlocking script (scriptSig) and the locking script (scriptPubKey). The locking script is from the transaction output that is being spent, while the unlocking script is included in the transaction input that is spending the output.


