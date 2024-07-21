# Solana VM

The library file is default file which includes all other modules. The crate will find the modules and item through this entry point file. The module can only be used in the current crate or publicly used by other crates. The current module can not use the other module by relative path. It should use the absolute path from the crate. The crate acts as the root module as well. The use items can be grouped together through the curly brace operator. 


