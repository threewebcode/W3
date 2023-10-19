# ThirdWeb SDK

EmbeddedWalletConnector is a connector implementation for an embedded wallet. It allows users to connect, disconnect, and interact with the wallet. The class has various methods such as `connect`, `disconnect`, `getAddress`, `isConnected`, `getProvider`, `getSigner`, and more. The class also has event listeners for handling account changes, chain changes, and disconnect events. It requires some options and dependencies to be passed during initialization.

These are TypeScript type definitions for an embedded wallet module. 

- The `EmbeddedWalletAdditionalOptions` type defines additional options for configuring the embedded wallet. It includes the `chain` property which represents the blockchain network details, `clientId` for identifying the client, and an optional `styles` property for customizing the wallet's appearance.

- The `EmbeddedWalletConnectorOptions` type is used to configure the connector for the embedded wallet. It includes the `clientId` for identifying the client, an array of `chains` representing the available blockchain networks, `chain` for specifying the current blockchain network, and an optional `styles` property for customizing the wallet's appearance.

- The `EmbeddedWalletConnectionArgs` type represents the arguments required for establishing a connection with the embedded wallet. It includes an optional `chainId` property to specify the blockchain network, and one of the following login types: 
  - `headless_google_oauth` for headless login using Google OAuth. It may include an `openedWindow` and a `closeOpenedWindow` function for handling the login process.
  - `headless_email_otp_verification` for headless login using email and OTP verification. It requires an `email` and an `otp`.
  - `ui_email_otp` for UI-based login using email and OTP verification. It requires an `email`.

The auth module defines various types and interfaces used within the file. 

Here's a brief explanation of each type:

- `RecoveryShareManagement`: An enum representing different options for recovery share management.
- `AuthProvider`: An enum representing different authentication providers.
- `GetHeadlessLoginLinkReturnType`: A type representing the return value of a function, which includes a login link.
- `StoredTokenType`: A type representing a stored token, including a JWT token, authentication provider, authentication details, and developer client ID.
- `AuthStoredTokenWithCookieReturnType`: A type representing the return value of a function, which includes a stored token with additional properties like a cookie string, flag indicating whether to store the cookie string, and a flag indicating if the user is new.
- `AuthAndWalletRpcReturnType`: A type representing the return value of a function, which includes both the `AuthStoredTokenWithCookieReturnType` and wallet details.
- `AuthLoginReturnType`: A type representing the return value of a function, which includes information about the logged-in user.

These type definitions are used within the file for type checking and documenting the expected data structures.

The LocalStorage class provides methods for storing and retrieving data in the browser's local storage. Here's a breakdown of the code:

1. The code imports constants from "../../constants/settings" which presumably contain the names of the keys used in the local storage.

2. The code defines a new Map called "data" to store data if the browser's local storage is not supported.

3. The LocalStorage class is exported.

4. The class constructor takes an object with a "clientId" property.

5. The "isSupported" property is set to true if the browser supports local storage, otherwise false.

6. The "clientId" property is stored in the class instance.

7. The "getItem" method is defined to retrieve an item from local storage. If local storage is supported, it uses the window.localStorage.getItem method, otherwise it retrieves the item from the "data" Map.

8. The "setItem" method is defined to store an item in local storage. If local storage is supported, it uses the window.localStorage.setItem method, otherwise it stores the item in the "data" Map.

9. The "removeItem" method is defined to remove an item from local storage. If local storage is supported and the item exists, it uses the window.localStorage.removeItem method, otherwise it returns false.

10. The "saveAuthCookie" method stores an authentication cookie in local storage using the "setItem" method.

11. The "getAuthCookie" method retrieves the authentication cookie from local storage using the "getItem" method.

12. The "removeAuthCookie" method removes the authentication cookie from local storage using the "removeItem" method.

13. The "saveDeviceShare" method stores a device share and associated user ID in local storage using the "setItem" method. It also saves the user ID separately using the "saveWalletUserId" method.

14. The "getDeviceShare" method retrieves the device share from local storage based on the client ID and user ID using the "getItem" method.

15. The "removeDeviceShare" method removes the device share from local storage based on the client ID and user ID using the "removeItem" method.

16. The "getWalletUserId" method retrieves the user ID from local storage using the "getItem" method.

17. The "saveWalletUserId" method stores the user ID in local storage using the "setItem" method.

18. The "removeWalletUserId" method removes the user ID from local storage using the "removeItem" method.

The IframeCommunicator is used for creating and managing communication with an iframe element in a web page.

Here is a breakdown of the code:

- The class takes an object of type `IFrameCommunicatorProps` as a constructor parameter. This object contains properties such as `link` (URL of the iframe), `iframeId` (ID of the iframe element), `container` (optional container element to append the iframe to), `iframeStyles` (optional styles to apply to the iframe), and `onIframeInitialize` (optional callback function to be called when the iframe is initialized).

- The class has a private property `iframe` which represents the HTMLIFrameElement.

- The class has a constant `POLLING_INTERVAL_SECONDS` which specifies the interval for checking if the iframe is loaded.

- The class has a method `onIframeLoadedInitVariables` which is a hook for initializing variables once the iframe is loaded. It returns a promise that resolves to a record of variables.

- The class has a method `onIframeLoadHandler` which is a callback function to be executed when the iframe is loaded. It initializes a MessageChannel to communicate with the iframe and sends an "initIframe" event to the iframe with the initialized variables.

- The class has a method `call` which is used to call a procedure in the iframe. It waits for the iframe to be loaded before sending the message. It also has an optional parameter `showIframe` to control whether to display the iframe while the procedure is being called.

- The class has a method `destroy` which should be called when the iframe is removed from the DOM to reset the global loaded state of that iframe.

The class AbstractLogin is an abstract class that serves as a base for implementing different login methods. Here is a breakdown of its structure:

- Import statements: The class imports various types and interfaces from different files.
- Type definitions: The class defines several type aliases for different login-related parameters and return types.
- Class definition: The `AbstractLogin` class is defined as an abstract class.
- Constructor: The constructor takes an object as a parameter, which includes a `querier` (an instance of `EmbeddedWalletIframeCommunicator`), `preLogin` and `postLogin` functions, and a `clientId`.
- Abstract methods: The class declares three abstract methods: `loginWithModal`, `loginWithEmailOtp`, and `loginWithGoogle`. These methods need to be implemented by any class that extends `AbstractLogin`.
- `sendEmailLoginOtp` method: This method sends an email with a login OTP (one-time password) to the specified email address. It calls the `preLogin` method, then uses the `LoginQuerier` instance to make a remote procedure call (`call`) to send the OTP.
- `verifyEmailLoginOtp` method: This method verifies the OTP entered by the user for email login. It also calls the `preLogin` method and uses the `LoginQuerier` instance to make a remote procedure call (`call`) to verify the OTP.
- Other class properties: The class has other protected properties like `LoginQuerier`, `preLogin`, `postLogin`, and `clientId`.

The class BaseLogin extends an abstract class called "AbstractLogin" and implements several login methods. 

The class has the following methods:

1. `getGoogleLoginUrl()`: This method retrieves the Google login URL from an API endpoint.

2. `loginWithModal()`: This method performs a login using a modal window.

3. `loginWithEmailOtp()`: This method performs a login using an email and OTP (One-Time Password).

4. `closeWindow()`: This method is a utility function to close a window.

5. `loginWithGoogle()`: This method performs a login using Google authentication. It opens a pop-up window and redirects to the Google login URL. It listens for messages from the pop-up window to handle successful or failed login attempts.

6. `verifyEmailLoginOtp()`: This method verifies the email login OTP (One-Time Password) entered by the user.

The `EthersSigner` class is used to interact with an Ethereum wallet and perform various signing operations.

Here's a breakdown of the code:

- The class imports various dependencies from the `ethers` library, including `Bytes`, `Signer`, `TypedDataDomain`, `TypedDataField`, and `providers`.
- It also imports some types related to the embedded wallets and signer interfaces.
- The class imports a `Provider` from an "ethereum-provider" module and an `EmbeddedWalletIframeCommunicator` from a custom iFrame communication utility.
- The class defines a type called `SignerProcedureTypes` that represents different types of signing procedures.
- The `EthersSigner` class is defined and extends the `Signer` class.
- The class has a constructor that takes a `provider`, `clientId`, and `querier` as arguments.
- The `getAddress`, `signMessage`, and `signTransaction` methods are overridden to provide implementation specific to the `EthersSigner` class.
- The `_signTypedData` method is a private method used internally to sign typed data.
- The `connect` method is overridden to create a new instance of `EthersSigner` with a different provider.

The embedded wallet provides functionality for managing a user's wallet, such as creating a wallet, setting up a new device, and getting the user's wallet status.

The class has the following properties and methods:

Properties:
- `clientId`: A string representing the client ID.
- `chain`: An object representing the blockchain chain.
- `walletManagerQuerier`: An embedded wallet iframe communicator.
- `localStorage`: An instance of the LocalStorage class.

Methods:
- `constructor`: Initializes the embedded wallet instance with the provided client ID, chain, and querier.
- `postWalletSetUp`: Sets up the user's device and wallet address.
- `getUserWalletStatus`: Retrieves the user's wallet status.
- `setChain`: Switches the chain that the user's wallet is currently on.
- `getEthersJsSigner`: Returns an Ethers.js compatible signer for interacting with the user's wallet


