# Smart Contract

1. generate the internal address
- return type: slice
- function specifier: impure and method id
- invoke random function to generate the address
- use the cell to store the data
- parse the cell and get the slice

2. receive external message
- slice type of incoming message
- load the signature from the slice and its length is 512 bits and 64 bytes. 
- load the sequence number and valid date from the slice message
- use throw if function to handle exception
- get the sequence number and public key from the contract cell storage
- use throw unless to validate the condition and process errors
- use public key to check the signature
- accept the message
- load the send mode and message from the incoming message
- send the raw message for further process
- store the sequence number and public key data

Multiple comments are enclosed by the curly brace and hyphen characters. The include directive is similar to the c language. Two semicolon is indicated for the single line comment. The impure specifier means that the function can have some side effects which can not be ignored. If the function is called exactly once, the inline specifier is the best. If it is called multiple times, The line ref specifier is more better choice. The inline reference function is placed into a separate cell by the virtual machine. 

The declaration of function is the function without body. To define a function means that the function is implemented completely. The underscore in the function return area indicates that this function is a modifying function and some of its return parameters are ignored because they are unused in the following code statements.

# Parser

The namespace serves the purpose of separating the code items. The symbol value has the type and id. The symbol could be parameters, variables, functions, type names, global variables and constant variables. The symbol table is able to add and lookup the keywords. The source code can be represented by the file description. The file description holds the file name and its text content. 

The position and offset of source code can be obtained from the source location structure type. It is a story of parsing the source codes and putting the lexical items into the symbol table. The source code is a text and string type. The string operators are used to accomplish this parsing work. Since language rules are specified and known, the language items are recognized by applying pattern on the given text.

# Compiler

The aim of the compiler is to convert the source codes into the assembly codes. The input may be from the file or from the standard input. The result can be written into file or print to standard output. The getopt function is harnessed to recognize each options and assign the value to the field of the object. 

The keywords related to type are int, cell, slice, builder, tuple, continuation, There are equations between the source codes and assembly codes. The code format is transitioned from the source codes into the assembly codes by applying the equation transformation. The intermedium format is the operation codes on the stack manipulation. 

The character, special character and their combination constitute the list of keyword. The operator is one kind of keywords. If the character dot or tilde appears in the expression, its subclass is extracted. The line content is outputted into the standard output. The include path is the vector of paths. 

The file is sourced and interpreted when the fift command is executed. The context is created for the interpretation process. The file could be a file in the memory or a file in the file system. The state of virtual machine is responsible for the cell creation, register and loading. Before running the codes in the virtual machine, certain conditions must be prepared and make them available during the execution. 

The elements of input parameter list are the code, stack, current state, virtual machine flags, log settings, gas limits, dependent libraries, and other optional data items. The register is introduced to help the stack data manipulation of the virtual machine. 

# Application

1. create application

```bash
npm create ton@lastest
npx blueprint help
export WALLET_VERSION="v4"
export WALLET_MNEMONIC=""
```

2. cli

```bash
wget https://github.com/ton-blockchain/ton/releases/download/v2024.08/func-linux-x86_64
wget https://github.com/ton-blockchain/ton/releases/download/v2024.08/fift-linux-x86_64
wget https://github.com/ton-blockchain/ton/releases/download/v2024.08/lite-client-linux-x86_64
pip install toncli
pip install bitstring==3.1.9
```
3. ecosystem


