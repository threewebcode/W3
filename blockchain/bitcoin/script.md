# Bitcoin Script

The extended public key is cached in the memory and can be easily fetched from the cache storage. The extended public key may be the parent public key or derived child public key. When producing the signature, different hash strategies can be adopted. It means that the data parts take part in the hash algorithm. Different data segments will affect the value of data hash so that the signature is also different.

The enumeration type is used to represent the signature version. The value of signature version denotes different script type and capability. It depicts the base script, witness script, taproot script and tapscript script.The input data of signature hash has different fixed length of bytes. 

All of methods are related to product the script data, calculate the hash, sign the data and verify the signature. 
