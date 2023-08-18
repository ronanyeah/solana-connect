interface ElmApp {
  ports: Ports;
}

interface Ports {
  disconnect: PortOut<boolean>;
  close: PortOut<null>;
  connect: PortOut<string>;
  copy: PortOut<string>;
  log: PortOut<string>;
  walletCb: PortIn<{ name: string; icon: string }>;
  walletTimeout: PortIn<null>;
  connectCb: PortIn<string | null>;
  disconnectIn: PortIn<null>;
}

interface PortOut<T> {
  subscribe: (_: (_: T) => void) => void;
}

interface PortIn<T> {
  send: (_: T) => void;
}

export { ElmApp };
