import { SolanaConnect } from "../src";

const BTN = document.getElementById("btn")!;
const TXT = document.getElementById("txt")!;
const PIC = document.getElementById("pic")! as HTMLImageElement;

reset();

const solConnect = new SolanaConnect({ debug: true });

BTN.onclick = () => solConnect.openMenu();

solConnect.onWalletChange((adapter) => {
  if (adapter && adapter.publicKey) {
    const key = adapter.publicKey.toString();
    TXT.innerText = key.slice(0, 6) + "..." + key.slice(-6);
    PIC.src = adapter.icon;
  } else {
    reset();
  }
});

solConnect.onVisibilityChange((open) => {
  console.log("👀 open:", open);
});

function reset() {
  PIC.src =
    "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAACXBIWXMAAAsTAAALEwEAmpwYAAABP0lEQVR4nO2Yy07DMBBF8yksiHiIHbXdXYUd+P8/YAGitN30xkEsQZaChAKJnHTsTKq5Uraec2QnnkxRSCQSiUQSmdrqW1SmLBLluFlfhhpJFq+f7q+91W/e6W1dmRvq9VGZ0jv12li184+ruyTwjdNf4aGWwA98uz6pRBeeWgJdeGqJz4258E49/ylAIIE+eOpdTiGRDT6FRHZ4SonZ4CkkZoc/RYIN/BQJdvBjJNjCx0g0Tu8bp97ZwkdK8IYfK8ES/rdE3XPeW/gDW/iQ8MJ+WL0d2AG+Ahj42rA/QoiEZymBIXir9wGWrQQiLqnwn+udemEngRE3LDsJTGgP2EjghN5mdgkQNGatRP7mDoRdZfYOFQkKZpNAwkLIIYGH1dWiB1v/SSxqtNiVWORwN9d4HZUpk43XJRKJRHKW+QaUqwzfL9sYYwAAAABJRU5ErkJggg==";
  TXT.innerText = "Not Connected";
}
