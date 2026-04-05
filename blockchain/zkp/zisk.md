# ZisK

ZisK converts RISC-V ELF binaries into verifiable proofs through a multi-stage pipeline involving transpilation, emulation and proof generation.

ZisK executor orchestrates witness computation across state machines, feeding into proof processor for final proof generation. The ZisKRom is optimized instruction storage format which contains instruction vectors, memory space, and loopup ROM vectors. 

Each computational domain has its own state machine. Main state machine tracks program execution flow and instruction execution. ROM state machine handles ROM data access and histogram computation. Memory state machine manages memory operations with planning optimization. Binary state machine processes binary and bitwise operations. Arithmetic state machine handles arithmetic operations. 
