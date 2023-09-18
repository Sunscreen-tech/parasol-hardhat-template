const networks: { [key: string]: { [key: string]: any } } = {
  'testnet': {
    url: "https://rpc.sunscreen.tech/parasol",
    chainId: 574,
    accountAddress: "ENTER ACCOUNT ADDRESS FOR TESTNET HERE",
    accountPrivateKey: "ENTER PRIVATE KEY FOR TESTNET HERE",
  },
  'local': {
    url: "http://127.0.0.1:8545",
    chainId: 31337,
    accountAddress: "ENTER ACCOUNT ADDRESS FOR LOCAL NET HERE",
    accountPrivateKey: "ENTER PRIVATE KEY FOR LOCAL NET HERE",

  },
};

export default networks;
