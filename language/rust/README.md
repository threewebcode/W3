Rust is programming language. It has its own language constructs, memory model, concurrent model, runtime service and linkage model. 

Tokens are the primitive productions in the language. The tokens have its categories such as keyword, identifier, literals, lifetime, punctuation and delimiter. These tokens are concatenated into language statements. The language clauses are broken down into different segments according to their kinds.

The macro invocation is processed at the compile time. The effect of macro invocation is to replace the invocation with the result of macro function.

The macro function should recognize the input parameters. The metavariables are used to denote different kinds of code fragments. When the input elements are matched with right metavariable, how many times of repeating the same operation are the next important aspect in the macro invocation.

Three flavors of procedural macro are function-like macro, derive macro and attribute macro. Procedural macros provides the opportunity to run codes during the compile time. The operations are performed on the Rust syntax.Both of input and output are Rust syntax. As a result, the macro operation consumes the original syntax and produce the generated syntax. The procedural macro is the transformation function of abstract syntax tree.

The compilation models center on artifacts called crates. Each compilation processes a single crate in the source form and produce a single crate in binary form. A crate is a unit of compilation and linking, as well as version, distribution, and runtime loading. A crate contains a tree of nested module scopes. Any item in the crate has a canonical module path denoting its location within the module tree. 

When the compiler processes one source file, it may load other source files as dependent modules. A source file describe the module's name and location which is in the module tree of current crate. Every source file is a module, but not every module needs a separate source file.

An item is a component of a crate. Items are organized by a nested set of modules within a crate. Items are entirely determined by the compile time, generally fixed at the execution time. A module is a container of zero or more items. A crate contains one or more module items. The module item is a module which is surrounded with curly brace, has its name and prefixed with mod keyword. The item types in the module item can not have the same name as the name of module item. 

A module without a body is loaded from an external file. The path attribute can influence the directories and files for loading the external file module. A use declaration is used to shorten the path required to refer to a module item. The use declaration is private to the containing module. A function consists of a block,along with a name, a set of parameters and an output type. A type alias defines a new name for existing type. 

A trait describes an abstract interfaces that the type implements. The interface consists of associated items. The associated items cann be constant, types and functions. All traits have an implicit type which refers to the concrete type which implements that trait. The associated type must never define the type, the type may only be specified in the implementation.

Inherent implementation can contain associated functions and constants, but can not include the type alias. A type can have multiple inherent implementations. The inherent implementation must be defined in the same crate as the original type.

The implementation may contain the outer attributes and inner attributes. The non exhaustive attribute indicates that a type may have more fields or variants added in the future.

Rust deals with the low-level details of memory management, data representation, and concurrency. Cargo is the build system and package manager. By default, the variable is immutable. Every value is of a certain data type.

A scalar type represents a single value. An integer is a number without fractional component. Compound types can group multiple values into one type. A tuple is a generic way of grouping together a number of types into one component type. 

The statments are the instructions that perform actions and do not return a value. The expressions are evaludated to a result value. Ownership is a set of rules that govern how a program manages memory. Memory is managed through a system of ownership with a set of rules that the compiler checks. 

Patterns can be made up of literal values, variable names, wildcard, and many other things. The values can be wrapped in the body of enumeration items. The match clause examines each enum type and pass the values to the matched branch. 

When the code organization should be considered, the path, module, crate and package should be adopted and applied. The codes are break down into small units and grouped together. The vector, string and hash map are the collection data structures from standard libraries. The revoverable errors are handled by the Result enum type. There are two instances of Result types. The Success is used in the positive situation while the Error type is used in the wrong situation.

The generic function can reduce duplicate codes. The generics data type can be used in the function definition, struct definition, enumeration definition, method definition. The trait is introduced to define the shared behaviors. The trait can be implemented on a type. The trait can be used as the input parameters. Multiple traits can be added together. 

The where clause can specify the trait boundary for each generics. The type constraint is more clearer when using the where clause. The main aim of life time is to prevent danling reference. It ensures that the reference is still existed when it is consumed in the another place.

A pointer is a general concept for a variable that contains an address in memory. The most common kind of pointer is a reference. Smart pointers are data structures that act like a pointer, but also have additional metadata and capabilities. Smart pointers are usually implemented using structs. The smart pointer pattern is a general design pattern. 

Boxes allow you to store the data on the heap rather than on the stack. Implementing the Deref trait allows you to customize the behavior of deference operator. The body of the drop function is where you would place any logic that you want to run when an instance of your type goes out of the scope. The reference counting type keeps track of the number of reference to a value to determine whether or not the value is still in use. 


