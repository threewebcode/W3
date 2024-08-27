# The Open Network

It is a huge distributed supercomputer. It is a collection of blockchain. They are unique master blockchain and working blockchains. The working blockchain can divide into the shard chains. The block hash on the master chain act as the global state. Everything is a bag of cell. The virtual machine is a stack machine. Both of bit strings and byte strings are supported. Messages are sent from one account to another account.

The contract language is function c style. It is compiled into assembly codes. The assembly codes are converted into binary codes by the fift assembler. The operation codes can be used directly the func language. The functions can also be implemented by the assembly codes.

## Smart Contract

The smart contract is made of codes and data. The data is the state and the code is logic. The language has strict types. The error during the compilation time can detect the problem ahead of runtime. Here is a [tutorial](http://tonhelloworld.com/02-contract/) for reference.

The explorer used for ton network is [tonviewer](https://tonviewer.com/). The open network has its own enhanced [proposals](https://github.com/ton-blockchain/TEPs). To be like the ethereum, it also has its research [hub](https://tonresear.ch/). 

## FunC Language

A cell can be transformed into a slice. The slice bits can be loaded from the cell. The [blueprint](https://github.com/ton-org/blueprint) is all-in-one tool for writing, testing and deploying FunC smart contract. The token contracts implemented by the FunC language can be founder [here](https://github.com/ton-blockchain/token-contract)

The ton official provides some [examples](https://docs.ton.org/develop/smart-contracts/examples) of smart contracts and they can used as reference. 

## Token Contract

The standard specifies the transfer, retrieval and display of fungible tokens and its interfaces. All of the interactions are specified and clarified. The data format are confirmed. The main actions of fungible token are transfer, display and query. 

## Standard Functions

The get data function is used to access the persistent storage for the contract. The set data function is used to modify the state storage of the contract. The send raw message is able to send the message to other contract. The receive internal function is capable of handling the messages from the other contracts. The receive external function is responsible for processing the messages from the users. 

## Assembly Language

The syntax of assembly language is like this: operand + operator. That is to say, the value is pushed on the stack firstly. The operation is performed on the stack secondly. The constant variable is one word of the assembly wordlist. The new word is defined by the following format: director block + colon + word name. 

Fift supports the following data types:
- `Integer`: Signed 257-bit integers
- `Cell`: TVM cells
- `Slice`: Partial views of cells, used for parsing
- `Builder`: Used for building new cells
- `Null`: A special "null" value
- `Tuple`: Ordered collections of values
- `String`: UTF-8 strings
- `Bytes`: Arbitrary sequences of bytes

Fift has a set of built-in primitives, or words, that can be used to perform various operations on the stack. These include arithmetic operations, cell manipulation, string handling, and more. The full list of primitives is documented in the Fift documentation.

Users can define new words (functions or macros) in Fift by using the `: name ... ;` syntax. These new words can then be used just like the built-in primitives.

The operations are represented by the enumeration instructions. The instruction data is constructed by corresponding functions. The instruction is passed to program entry point and handled by the processor. The data are packed into slice and persisted into state.


