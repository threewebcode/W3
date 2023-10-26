# OpenZeppelin

### Contract

The ERC2981 standard is a standardized way to retrieve royalty payment information for non-fungible tokens (NFTs). This contract allows for the specification of royalty information globally for all token IDs or individually for specific token IDs. The royalty information includes the receiver of the royalty payment and the royalty fraction, which is specified as a fraction of the sale price.

It is important to note that ERC-2981 only specifies a way to signal royalty information and does not enforce its payment. Marketplaces are expected to voluntarily pay royalties together with sales, but this standard is not yet widely supported.

The ERC20 standard token in Ethereum defines the functions and events that a contract must implement in order to be considered ERC20 compliant. The interface includes functions for transferring tokens, checking balances, approving token transfers, and managing allowances.

ERC20 is a widely adopted standard for fungible tokens, meaning that each token is identical and can be exchanged on a one-to-one basis. The contract provides functions for transferring tokens between addresses, checking balances, and managing allowances for spending tokens on behalf of another address.

The library SafeERC20 provides safe wrappers around ERC20 token operations, ensuring that operations like transfer, transferFrom, increaseAllowance, and decreaseAllowance are executed successfully or revert in case of failure. The library is designed to handle tokens that return false, revert, or throw on failure. It also includes a function called forceApprove, which is used to set the allowance of a token to a specific value, even if the token requires the allowance to be set to zero before setting it to a non-zero value. This library is part of the OpenZeppelin Contracts project and is used to enhance the security and reliability of ERC20 token interactions.

The ERC4626 "Tokenized Vault Standard" defines a set of functions and behaviors for a tokenized vault contract that allows the minting and burning of "shares" in exchange for underlying "assets".

The contract extends the ERC20 standard and includes additional functions such as deposit, mint, redeem, and withdraw. It also provides preview functions to estimate the amount of shares or assets that will be obtained before performing the actual transaction. The contract includes various error conditions to handle cases where the maximum limits for deposit, mint, withdraw, or redeem are exceeded.

The contract uses a virtual shares and assets mechanism to mitigate the risk of attacks such as front-running and slippage. The virtual shares and assets capture a small part of the value being accrued to the vault. The contract also includes functions to convert between shares and assets based on the current exchange rate.

The ERC721 compliant contract defines the required functions and events for an ERC721 token. ERC721 tokens are non-fungible tokens (NFTs) that represent ownership over unique assets. The interface includes functions for transferring tokens, checking balances, approving token transfers, and managing operators.

The ERC721 token receiver defines a function called `onERC721Received` that is called when an ERC721 token is transferred to the contract using the `safeTransferFrom` function. The function takes four parameters: `operator` (the address of the operator performing the transfer), `from` (the address from which the token is being transferred), `tokenId` (the ID of the token being transferred), and `data` (additional data that can be passed along with the transfer). The function must return a bytes4 value that represents its Solidity selector to confirm the token transfer. If any other value is returned or the interface is not implemented by the recipient, the transfer will be reverted.

It is an abstract contract that provides the basic functionality for managing non-fungible tokens (NFTs) on the Ethereum blockchain.

ERC721 tokens are unique and indivisible, meaning each token has a distinct value and cannot be divided into smaller units. This makes them suitable for representing ownership of unique digital assets such as collectibles, game items, or real-world assets.

The ERC721 contract includes functions for minting, transferring, and managing ownership of tokens. It also implements the Metadata extension, allowing each token to have a name, symbol, and URI to retrieve additional metadata.

The ERC721Holder is an abstract contract that implements the IERC721Receiver interface. This contract is designed to accept all token transfers for ERC721 tokens. It ensures that the contract is able to use its tokens with functions such as safeTransferFrom, approve, or setApprovalForAll. The onERC721Received function is implemented to always return the onERC721Received.selector value from the IERC721Receiver interface.

The Proxy contract provides a fallback function that delegates all calls to another contract using the EVM instruction `delegatecall`. The contract that receives the delegated calls is referred to as the "implementation" and needs to be specified by overriding the virtual `_implementation` function.

The contract also provides the `_delegate` function, which allows manual triggering of delegation to a different contract. The success and return data of the delegated call will be returned back to the caller of the proxy.

The fallback function in the contract delegates calls to the address returned by the `_implementation` function. If no other function in the contract matches the call data, the fallback function will be executed.


