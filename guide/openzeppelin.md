# OpenZeppelin

### Contract

The ERC2981 standard is a standardized way to retrieve royalty payment information for non-fungible tokens (NFTs). This contract allows for the specification of royalty information globally for all token IDs or individually for specific token IDs. The royalty information includes the receiver of the royalty payment and the royalty fraction, which is specified as a fraction of the sale price.

It is important to note that ERC-2981 only specifies a way to signal royalty information and does not enforce its payment. Marketplaces are expected to voluntarily pay royalties together with sales, but this standard is not yet widely supported.

The ERC20 standard token in Ethereum defines the functions and events that a contract must implement in order to be considered ERC20 compliant. The interface includes functions for transferring tokens, checking balances, approving token transfers, and managing allowances.

ERC20 is a widely adopted standard for fungible tokens, meaning that each token is identical and can be exchanged on a one-to-one basis. The contract provides functions for transferring tokens between addresses, checking balances, and managing allowances for spending tokens on behalf of another address.


