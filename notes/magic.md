# Magic Link

Keywords: 1) distributed identity token; 2) delegated key management; 3) master key; 4) hardware security module;

The basic function is to send transaction in the asynchronic way.

### SDK

The code defines a base class for creating extensions to the core Magic JS APIs. These extensions enable new functionality by composing Magic endpoints methods together.

The code includes the following key components:

- `BaseExtension` class: This is an abstract class that serves as the base for all extensions. It extends the `BaseModule` class and provides common functionality and utilities.

- `InternalExtension` class: This is a subclass of `BaseExtension` that represents "official" extensions. It includes a `config` property and is intended for internal use.

- `Extension` class: This is another subclass of `BaseExtension` that represents regular extensions. It includes the `name` property and is designed for open-source extension development.

- `WithExtensions` type: This type is used to wrap a Magic SDK constructor with the necessary type information to support a strongly-typed `Extension` interface.

- `InstanceWithExtensions` type: This type represents an instance of the Magic SDK with extensions. It includes properties for each extension, excluding anonymous extensions.

The base  module contains methods for making requests to a Magic `<iframe>` context and handling events from the `<iframe>`. It also includes a method for creating an intermediary event.

The `BaseModule` class has the following properties and methods:

- `constructor(sdk: SDKBase)`: The constructor function that takes an SDK instance as a parameter.
- `overlay(): ViewController`: A getter method that returns the `ViewController` for the SDK instance registered to this module.
- `request<ResultType = any, Events extends EventsDefinition = void>(payload: Partial<JsonRpcRequestPayload>)`: A method for sending promisified requests to the Magic `<iframe>` context. It takes a partial JSON-RPC request payload as a parameter and returns a `PromiEvent` that resolves or rejects based on the response from the `<iframe>`. It also listens for events from the `<iframe>` and emits them to the `PromiEvent` subscribers.
- `createIntermediaryEvent<T = Function>(eventType: IntermediaryEvents, payloadId: string)`: A method for creating an intermediary event. It takes an event type and a payload ID as parameters and returns a function that can be used to emit the event to the Magic `<iframe>` context.

The `UserModule` class contains various methods related to user authentication and account management. Here is a brief overview of the methods:

- `getIdToken(configuration?: GetIdTokenConfiguration)`: This method retrieves the ID token for the currently logged-in user.
- `generateIdToken(configuration?: GenerateIdTokenConfiguration)`: This method generates a new ID token for the user.
- `getInfo()`: This method retrieves information about the currently logged-in user.
- `isLoggedIn()`: This method checks if a user is currently logged in.
- `logout()`: This method logs out the current user.
- `requestInfoWithUI(scope?: RequestUserInfoScope)`: This method requests the user's email address with a user interface.
- `showSettings(configuration?: ShowSettingsConfiguration)`: This method shows the user settings page.
- `recoverAccount(configuration: RecoverAccountConfiguration)`: This method initiates the account recovery process.
- `getMetadata()`: This method retrieves metadata about the currently logged-in user. (Deprecated)
- `updateEmail(configuration: UpdateEmailConfiguration)`: This method updates the user's email address. (Deprecated)

The class also has a private member named `localForageKey` used for storing the active wallet information.

The wallet module provides various methods for interacting with wallets, such as connecting to a wallet, showing wallet UI, sending transactions, and getting wallet information.

The class has several public methods, including `connectWithUI`, `showUI`, `showAddress`, `showSendTokensUI`, `showOnRamp`, `showNFTs`, `showBalances`, `sendGaslessTransaction`, `getInfo`, `disconnect`, and `requestUserInfoWithUI`. It also has a private method called `getProvider`.

The class imports various types and functions from different modules, such as `@magic-sdk/types`, `./base-module`, and `../core/json-rpc`. It also uses methods from the `util` module for storage and event handling.

The auth module implements various authentication methods using the Magic SDK. Here's a breakdown of the module:

- The module exports several types and constants related to authentication methods.
- The `AuthModule` class extends a `BaseModule` class and provides methods for different authentication flows.
- The `loginWithMagicLink` method initiates the "magic link" login flow for a user by sending a request to the server.
- The `loginWithSMS` method initiates an SMS login flow for a user by sending a request to the server.
- The `loginWithEmailOTP` method initiates an Email with OTP login flow for a user by sending a request to the server.
- The `loginWithCredential` method logs a user in with a special one-time-use credential token.
- The `setAuthorizationToken` method sets an authorization token for the current session.
- The `updateEmailWithUI` method updates the user's email address with a UI for interaction.

The RPCProviderModule class implements the EIP 1193 specification for Ethereum providers, which allows applications to interact with Ethereum networks using JSON-RPC requests.

The class provides methods for sending JSON-RPC requests asynchronously (`sendAsync`) and synchronously (`send`). It also implements event emitter methods (`on`, `once`, `addListener`, `off`, etc.) to handle events.

The `enable` method is used to enable the provider and initiate the authentication process.

The class extends the `BaseModule` class and overrides the `request` method to add a test-mode prefix to RPC methods when necessary.


