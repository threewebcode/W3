# AIRBender

The same program can be compiled into x86 and risc-v architectures. Both systems execute identical code with identical inputs. There is no operating system in the bare-metal environment. Trusted code model and ROM-based bytecode storage model are used in airbender system. Delegations integrate seamlessly with the main circuit through a unified memory argument. Register reads, writes, and memory accesses in delegation circuits participate in the same consistency checks as regular risc-v operations. 

Its architecture balances several competing requirements. The prime field provides optimal representation for 32-bit risc-v values while enabling efficient arithmetic operations. The five stage pipeline architecture operates linearly: witness low degree extension computation, memory and loopup argument setup, quotient polynomial evaluation, deep optimization, and FRI proof generation.

The system uses the term and constraint types to represent algebraic constraints, with automatic normalization enforcing the degree-2 limit before constraints are accepted by the circuit. The most distinctive design pattern in airbender is the orthogonal selection optimization. The circuit prepares candidate computations for many instruction handlers, but enforces only the active one via mutually exclusive boolean flags. The lookup-centric design extends to delegation circuits, which use dedicated lookup tables for delegation operations.

Specialized delegation circuits execute outside the main risc-v semantics, but inside the same proving system. 
