Rust is programming language. It has its own language constructs, memory model, concurrent model, runtime service and linkage model. 

Tokens are the primitive productions in the language. The tokens have its categories such as keyword, identifier, literals, lifetime, punctuation and delimiter. These tokens are concatenated into language statements. The language clauses are broken down into different segments according to their kinds.

The macro invocation is processed at the compile time. The effect of macro invocation is to replace the invocation with the result of macro function.

The macro function should recognize the input parameters. The metavariables are used to denote different kinds of code fragments. When the input elements are matched with right metavariable, how many times of repeating the same operation are the next important aspect in the macro invocation.

Three flavors of procedural macro are function-like macro, derive macro and attribute macro. Procedural macros provides the opportunity to run codes during the compile time. The operations are performed on the Rust syntax.Both of input and output are Rust syntax. As a result, the macro operation consumes the original syntax and produce the generated syntax. The procedural macro is the transformation function of abstract syntax tree.

The compilation models center on artifacts called crates. Each compilation processes a single crate in the source form and produce a single crate in binary form. A crate is a unit of compilation and linking, as well as version, distribution, and runtime loading. A crate contains a tree of nested module scopes. Any item in the crate has a canonical module path denoting its location within the module tree. 

When the compiler processes one source file, it may load other source files as dependent modules. A source file describe the module's name and location which is in the module tree of current crate. Every source file is a module, but not every module needs a separate source file.

An item is a component of a crate. Items are organized by a nested set of modules within a crate. Items are entirely determined by the compile time, generally fixed at the execution time. A module is a container of zero or more items. A crate contains one or more module items. The module item is a module which is surrounded with curly brace, has its name and prefixed with mod keyword. The item types in the module item can not have the same name as the name of module item. 

A module without a body is loaded from an external file. The path attribute can influence the directories and files for loading the external file module. A use declaration is used to shorten the path required to refer to a module item. The use declaration is private to the containing module. A function consists of a block,along with a name, a set of parameters and an output type. A type alias defines a new name for existing type. 


