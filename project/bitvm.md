# BitVM

## Papers

- [Schnorr Signed Program](https://arxiv.org/pdf/2503.02772)

The current bitcoin crates are leveraged to create high-level syntax constructs. The stack variable has the properties of identity and storage size. The stack operations are described by enumeration type. Both of main stack and alternative stack are existed in the bitcoin script design. The stack data represents the data on the stack. The storage location, bytes size and state change are its main characteristics. 

The script macro is defined to create the bitcoin script. The bitcoin script can be execued in the bitcoin stack machine. The boolean result is returned from stack. The element in the stack may be either number or other types which can be translated into boolean value by logic operation. The standard script consists of operation code and number or hex string operand. The variable is delimited by particular character. 

The whole program is split into small pieces. Each piece is depiected by independent data type. These data types can be composed, refered and put together to achive some behaviors and capabilities. 
