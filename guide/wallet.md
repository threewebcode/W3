# Wallet 

### Demo

1. https://thirdweb.com/chainlist
2. https://web-demo.particle.network
3. https://demo.privy.io

### Social Login Wallet

1. https://docs.sequence.xyz/wallet/key-management/social-login-wallets


### Embedded Wallet

1. https://portal.thirdweb.com/embedded-wallet
2. https://docs.privy.io/guide/frontend/embedded/overview


### Rainbowkit

1. https://docs.zerodev.app/create-wallets/social#rainbowkit

**Usage**

RainbowKit is a React library. Configure your desired chains and generate the required connectors. Wrap your application with RainbowKitProvider and WagmiConfig. Then, in your app, import and render the ConnectButton component. You can optionally enforce that users sign a message with their wallet during the connection process, proving that they own the connected account and allowing you to create an authenticated user session with privileged access to your application.

You can import individual wallets from '@rainbow-me/rainbowkit/wallets' along with the connectorsForWallets function to build your own list of wallets with their necessary connectors. This way you have full control over which wallets to display, and in which order.


