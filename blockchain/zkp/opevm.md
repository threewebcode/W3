# OpenVM

OpenVM uses a system bus architecture where specialized chips handle specific instruction classes. The VMExecutor dispatches instructions to the appropriate extension executors. Every extension follows a three-component pattern. The extension triplet pattern is composed of guest library, transpiler and circuit. 

OpenVM uses a trait-based configuration system to compose VM instances from extensions. The execution engine consists of executor and interpreter. The executor orchestrates program execution across extensions. The interpreter is standard bytecode interpreter. The virtual machine state management is state of register files, program counter and memory contents. The address spaces are segregated regions for program, registers, heap, stream io, native field and custom extensions. 

The interpreter is the runtime engine that executes preprocessed program instructions using function pointers and pre-computed data. The execution loop is the heart of the interpreter, repeatedly fetching and executing instructions util termination or suspension. 
