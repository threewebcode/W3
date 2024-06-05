# Interfaces for interacting with Ethereum network

1. Event Subscription
    - unsubscribe method
    - error method

2. Chain Reader
    - block by hash
    - block by number
    - header by hash
    - heder by number
    - transaction count
    - transaction in block
    - subscribe new head

3. Transaction Reader
    - transaction by hash
    - transaction receipt

4. State Reader
    - balance at by address and block number
    - storage at by address, key and block number
    - code at by address and block number
    - nonce at by address and block number

5. Synchronization Progress
    - starting block
    - current block
    - highest block
    - pulled states
    - known states
    - synced accounts
    - synced bytecodes
    - synced storage
    - healed trie nodes
    - healed bytecodes
    - transaction index finished blocks
    - transaction index remaining blocks

6. Call Message
    - from address
    - to address
    - gas
    - gas price
    - value
    - data
    - access list
    - blob gas fee
    - blob hashes

7. Contract Caller
    - call contract
        - context
        - call message
        - block number

8. FilterQuery
    - block hash
    - from block
    - to block
    - address list
    - topic list

9. LogFilter
    - filter logs
        - context
        - filter query
    - subscribe filter log
        - context
        - filter query
        - log channel

10. Transaction Sender
    - send transaction
        - context
        - transaction

11. Gas Pricer
    - suggest gas price
        - context

12. Fee History Reader
    - fee history
        - oldest block
        - reward
        - base fee
        - gas used ratio

13. Pending State Reader
    - pending balance at address
    - pending storage at key and address
    - pendinf code at address
    - pending nonce at address
    - pending transaction count

14. Gas Estimator

15. Block Number Reader

16. Chain ID Reader
