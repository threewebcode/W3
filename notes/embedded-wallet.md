# Embedded Wallet

### ThirdWeb 

The EmbeddedWalletConnector is a connector implementation for an embedded wallet. Here are some key points about this class:

- It extends the `Connector` class, which indicates that it is a connector for a specific type of wallet.
- It has properties such as `id`, `name`, and `ready` to identify and manage the connector.
- It has a `user` property to store user information once connected.
- It has an `options` property to store configuration options for the embedded wallet.
- It has methods for connecting, disconnecting, getting the address, checking if connected, getting the provider, getting the signer, and managing chain switching.
- It has event listeners for handling account changes, chain changes, and disconnection events.
- It has a method to get the user's email.

TypeScript type definitions for an embedded wallet. 

- `EmbeddedWalletAdditionalOptions` defines additional options for the embedded wallet, including the selected chain, client ID, and optional styles.
- `EmbeddedWalletConnectorOptions` defines the options for connecting to the embedded wallet, including the client ID, available chains, selected chain, and optional styles.
- `EmbeddedWalletConnectionArgs` defines the different types of connection arguments for the embedded wallet, including the chain ID and the login type. The login type can be "headless_google_oauth" with an optional opened window and a function to close the opened window, "headless_email_otp_verification" with an email and OTP, or "ui_email_otp" with an email.

The constant module exports several constants and functions related to an embedded wallet and authentication. Here is a breakdown of what each constant and function does:

- `EMBEDDED_WALLET_PATH`: A string constant representing the path to the embedded wallet.
- `HEADLESS_GOOGLE_OAUTH_ROUTE`: A string constant representing the route for headless Google OAuth login.
- `GET_IFRAME_BASE_URL`: A function that returns the base URL for an iframe. It replaces "withpaper.com" in the paper origin URL with "ews.thirdweb.com".
- `WALLET_USER_DETAILS_LOCAL_STORAGE_NAME`: A function that returns the local storage name for wallet user details based on the provided `clientId` parameter.
- `WALLET_USER_ID_LOCAL_STORAGE_NAME`: A function that returns the local storage name for wallet user ID based on the provided `clientId` parameter.
- `AUTH_TOKEN_LOCAL_STORAGE_NAME`: A function that returns the local storage name for the authentication token based on the provided `clientId` parameter.
- `DEVICE_SHARE_LOCAL_STORAGE_NAME`: A function that returns the local storage name for device share based on the provided `clientId` and `userId` parameters.

The EmbeddedWalletSdk is used to manage the authentication and wallet functionality for a third-party embedded wallet. Here's a breakdown of the class:

- The class has a constructor that takes an object with three parameters: `clientId`, `chain`, and `styles`. `clientId` represents the unique identifier for the embedded wallet, `chain` represents the default blockchain on which the wallet operates, and `styles` represents the default style override for any modal that appears during wallet creation or login.

- The constructor initializes the `clientId` and creates an instance of `EmbeddedWalletIframeCommunicator` and `EmbeddedWallet`. It also creates an instance of `Auth` for managing the authentication state.

- The class has a method called `getUser()` which returns information about the user's authentication and wallet status. It uses the `getUserWalletStatus()` method from the `EmbeddedWallet` instance to determine the user's status and returns an object with relevant information.

- The class also has a private method called `isClientIdLegacyPaper()` which checks if the provided `clientId` is a legacy format. If it is, an error is thrown.

The auth.ts file includes TypeScript type definitions for an authentication and wallet management system. 

- `AuthDetails` represents the details of the authentication process.
- `InitializedUser` represents a user who has been successfully initialized.
- `SetUpWalletRpcReturnType` represents the details of the wallet setup process.
- `RecoveryShareManagement` is an enum that defines different types of recovery share management options.
- `AuthProvider` is an enum that defines different authentication providers.
- `GetHeadlessLoginLinkReturnType` is a type that defines the return value of a function that generates a headless login link.
- `StoredTokenType` is a type that represents a stored token, including the JWT token, authentication provider, authentication details, and developer client ID.
- `AuthStoredTokenWithCookieReturnType` is a type that represents the return value of a function that includes a stored token along with a cookie string, a flag indicating whether to store the cookie string, and a flag indicating if the user is new.
- `AuthAndWalletRpcReturnType` is a type that represents the return value of a function that includes the authentication stored token with cookie information and wallet details.
- `AuthLoginReturnType` is a type that represents the return value of a function that includes the user information after successful authentication.

The class BaseLogin extends the `AbstractLogin` class. It contains methods for logging in with different methods such as modal, email OTP, and Google. 

Some key points about this code:

- It imports various types and constants from different files.
- The `BaseLogin` class has a private method `getGoogleLoginUrl()` to fetch the login URL for Google.
- The `loginWithModal()` method performs a login using a modal dialog.
- The `loginWithEmailOtp()` method performs a login using email and OTP (One-Time Password).
- The `loginWithGoogle()` method performs a login using a Google account. It opens a new window, fetches the login URL from the server, and redirects the user to that URL. It listens for events from the login window and resolves or rejects the login based on the received events.
- The `verifyEmailLoginOtp()` method verifies the email login OTP.


