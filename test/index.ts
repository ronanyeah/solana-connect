import { SolanaConnect } from "../src";

const solConnect = new SolanaConnect({ debug: true });

solConnect.openMenu();

solConnect.onWalletChange((adp) =>
  adp
    ? console.log("connected:", adp.name, adp.publicKey.toString())
    : console.log("disconnected")
);

solConnect.onVisibilityChange((open) => {
  console.log("open:", open);
  if (!open) {
    setTimeout(() => solConnect.openMenu(), 1000);
  }
});
