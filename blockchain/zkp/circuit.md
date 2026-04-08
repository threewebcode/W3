# Circuit

When the VM encounters a Call bytecode instruction for a native, it looks up the function in the registry, it deserializes arguments from memory model, it calls the corresponding Rust closure or function, The Rust implementation performs the work and returns results or aborts with an error code. Gas metering is applied around the native call to prevent DoS. 
