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
