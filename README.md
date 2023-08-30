# Solana Connect
Standalone wallet UI for Solana dApps

[DEMO](https://solana-connect-demo.netlify.app/) | [DOCUMENTATION](https://solana-connect-docs.netlify.app/)

![wallet menu](assets/menu.png)

---

### __Usage:__
```
npm install solana-connect
```

```typescript
import { SolanaConnect } from "solana-connect";
import { Adapter } from "@solana/wallet-adapter-base";

const solConnect = new SolanaConnect();

solConnect.openMenu();

solConnect.onWalletChange((adapter: Adapter | null) =>
  adapter
    ? console.log("connected:", adapter.name, adapter.publicKey.toString())
    : console.log("disconnected")
);

solConnect.onVisibilityChange((isOpen: boolean) => {
  console.log("menu visible:", isOpen);
});

const wallet: Adapter | null = solConnect.getWallet();
```
or use with [unpkg](https://www.unpkg.com/):
```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <script src="https://www.unpkg.com/solana-connect"></script>
  </head>
  <body>
    <script>
      const solConnect = new window.SolanaConnect();
      solConnect.openMenu();
    </script>
  </body>
</html>
```

###  __Adding more adapters:__
By default, only wallets that support the [Wallet Standard](https://github.com/wallet-standard/wallet-standard) will appear, but additional options can be provided.
```typescript
import {
  SolanaMobileWalletAdapter,
  createDefaultAuthorizationResultCache,
  createDefaultAddressSelector,
  createDefaultWalletNotFoundHandler,
} from "@solana-mobile/wallet-adapter-mobile";
import { SolflareWalletAdapter } from "@solana/wallet-adapter-solflare";
import { UnsafeBurnerWalletAdapter } from "@solana/wallet-adapter-unsafe-burner";

const solConnect = new SolanaConnect({
  additionalAdapters: [
    new SolflareWalletAdapter(),
    new UnsafeBurnerWalletAdapter(),
    new SolanaMobileWalletAdapter({
      addressSelector: createDefaultAddressSelector(),
      appIdentity: {
        name: "Supercorp",
        uri: "https://supercorp.app/",
        icon: "icon.png",
      },
      authorizationResultCache: createDefaultAuthorizationResultCache(),
      cluster: "mainnet-beta",
      onWalletNotFound: createDefaultWalletNotFoundHandler(),
    }),
  ],
});
```
