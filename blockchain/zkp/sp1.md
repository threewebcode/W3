# Succinct

## Command Line

The main function is the entry point that provides 5 commands for prove actions. The command is implemented by the structure type and decorated by the command attribute macro. The command structure has several fields which are mapping with the arguments. The method of command structure is used to do the command operations.

## Core Package

The modules are defined in the library file. They are available for reference usage. The chip is describled by the Rust language and simulated by the Rust language. The chip implements the operation codes in the software layer. When the program is executed, its execution trace is captured for further verification.

All items are exposed in the module file. It includes the items from module declaration file, inner declared items and imported items from third parties's crates.

The runtime is responsible for executing a user program and tracing important events which occur during execution. The user program usually read the values from the memory and register, perform some computations and write back into the storage. The trace of user program execution can include two facets: cpu operation and memory operatrion. The cpu operation is driven by the operation codes. When the operation code is executed, the corresponding events are emitted and recorded as trace input. The state happens in the memory and they are also recorded as the execution trace.

The instruction is the abstraction over the operation codes. It can represent generic operation code. The instruction is equal to the operation code. The input and output stands for data operation which reads data from a device or writes data into a device.

The memory is a hardware device which provides the data container for the upper layer. The software implementation can act as the same emulation as the low level hardware. The operation codes are specific definitions instead of generic definitions because they are used only in the cases of zero knowledge proof. The virtual machine is domaim specific virtual machine. The zero knowledge programs are run in the virtual machine.

A program should encompass the instructions for computation and state transfer, possess the program counter for the base address and start address, and own the memory space for variables. A record of the execution of program contains event data for everything that happened during the execution period.

The register is a storage slot that comes from the hardware layer. The state is used to describe the status of a program in the different time spots. The system call is an enumeration type which depicts the limited number of system call operation codes. The system call is offered as the precompile function. The system call operation code has one-to-one relationship with the precompile function. 

There are various operation functions around the program verification. Some of these operations are particular for the field element. Field mathematics is used to do the cryptographic computations. 


