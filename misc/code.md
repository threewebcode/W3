# Code Notes

### Node

**Wait**

The function wait takes a parameter "ms" of type number. Inside the function, it creates a new Promise that resolves after a specified number of milliseconds using the setTimeout function.

This function can be used to introduce a delay in your code execution. By awaiting this promise, you can pause the execution for the specified duration before continuing with the next instructions.


### Viem

The wagmi Viem can provide the client, wrap the contract and execute the contract's functions with the configured network.
