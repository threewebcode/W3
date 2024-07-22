# Solana VM

The library file is default file which includes all other modules. The crate will find the modules and item through this entry point file. The module can only be used in the current crate or publicly used by other crates. The current module can not use the other module by relative path. It should use the absolute path from the crate. The crate acts as the root module as well. The use items can be grouped together through the curly brace operator. 

The debug procedural macro is applied to the structure type as the derive annotation. The account has the associated state. The debug trait forces the object to print itself in the formatted form. The default trait provides the default constructor function. The function can be chained and nested in the rust language. The transactions are executed against the matched accounts.


