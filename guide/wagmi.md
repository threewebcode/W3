# WAGMI

### Connector

The Connector class is an abstract class that serves as a base for creating different types of connectors. Connectors are used to connect to different blockchain networks and interact with them.

In simple terms, a connector is a software component that allows applications to connect to and communicate with blockchain networks. It provides methods and functionality to connect to a specific blockchain network, retrieve account information, interact with smart contracts, and perform various blockchain operations.

The Connector class has several abstract methods that need to be implemented by the subclasses. These methods include connecting to a blockchain network, disconnecting from the network, retrieving the connected account's address, retrieving the chain ID of the connected network, and getting the provider and wallet client for the network.

The Connector class also defines events that can be triggered during the connector's lifecycle, such as when the connection changes, when a connection is established, when a message is received, when a disconnection occurs, and when an error happens.

The Connector class has properties like the connector's unique ID, name, supported chains, options to use with the connector, and a storage property for storing data.

**Metamask Connector**

The MetaMaskConnector is a class that extends the InjectedConnector. It provides a way to connect to the MetaMask wallet and interact with it using the injected Ethereum provider.

Here's how it works:

1. The MetaMaskConnector class is imported along with other necessary dependencies.
2. The class is defined and extends the InjectedConnector class.
3. The class has a unique id property set to 'metaMask'.
4. The class has a protected property called shimDisconnectKey, which is used for storage purposes.
5. The class has an optional property called UNSTABLE_shimOnConnectSelectAccount, which allows the user to select a different MetaMask account when trying to connect.
6. The constructor of the class takes an optional object parameter with chains and options properties.
7. Inside the constructor, the options object is defined, which includes a name property set to 'MetaMask', shimDisconnect property set to true, and a getProvider function.
8. The getProvider function checks if the window object is available and tries to retrieve the Ethereum provider from it.
9. If the provider is found, it checks if it meets certain conditions to ensure it is the MetaMask provider.
10. The constructor then calls the constructor of the InjectedConnector class, passing the chains, options, and options parameters.
11. The connect method is defined, which takes an optional object parameter with chainId property.
12. Inside the connect method, it first tries to retrieve the provider using the getProvider method.
13. If the provider is not found, it throws a ConnectorNotFoundError.
14. If the provider supports event listeners, it registers event listeners for 'accountsChanged', 'chainChanged', and 'disconnect'.
15. It emits a 'message' event with type 'connecting'.
16. If the UNSTABLE_shimOnConnectSelectAccount property is enabled and the shimDisconnect property is active (true), and the shimDisconnectKey is not set in storage, it tries to get the current account using the getAccount method.
17. If an account is connected, it tries to show a prompt for selecting a different wallet using the 'wallet_requestPermissions' method.
18. If the user rejects the request or if the provider does not support 'wallet_requestPermissions', it throws a UserRejectedRequestError or ResourceUnavailableRpcError respectively.
19. If no account is connected or the prompt is shown and a different account is selected, it gets the accounts using the 'eth_requestAccounts' method and retrieves the first account.
20. If a chainId is provided and it is different from the current chainId, it switches to the specified chain using the switchChain method.
21. It stores the shimDisconnectKey in storage if the shimDisconnect property is enabled.
22. Finally, it returns an object with the connected account, chain information, and provider.

**WalletConnect Connector**

The WalletConnectConnector connector is used for integrating with the WalletConnect protocol, which allows users to connect their wallets to decentralized applications (dApps) using a QR code scanning process.

Here are the technical principles of the connector:

1. The connector imports necessary dependencies such as the WalletConnectProvider, EthereumProviderOptions, and various utility functions.
2. It defines the types and options required for configuring the connector.
3. The connector class extends a base class called "Connector" and implements the necessary methods and properties.
4. The connector has an ID ("walletConnect") and a name ("WalletConnect").
5. The connector is always ready for use.
6. The connector creates an instance of the WalletConnectProvider and initializes it with the provided options.
7. The connector provides methods for connecting and disconnecting from the wallet.
8. The connector can retrieve the connected account and chain ID.
9. The connector can switch to a different chain if supported by the wallet and requested chain is approved.
10. The connector handles events such as account changes, chain changes, disconnections, and display of QR code URI.
11. The connector emits events to notify the application about changes and messages from the wallet.


