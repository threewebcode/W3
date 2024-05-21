# RISC ZERO

The cryptographic functions are implemented by the circuits. The program is executed against the cryptographic  functions and the receipts are collected for proofing. The merkle root is one kind of proof. The Groth16 prover and verifier are implemented by rust language and used in this project.

The modules are defined in the library source file. The module name appears in the current scope. The functions are defined in this module. When this module is loaded and resolved, the items can be used directly. Various functions are created to handle different data types and do the mathematic computation. 

The seal object is structure type and holds three fields that represent the composition of a seal. The seal should know the element size and group size. The values and curve are expressed in the format of json. The vector data type is frequently used to stand for the data. The structure and vector data instance are the valid data input of enumeration types.


