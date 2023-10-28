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


