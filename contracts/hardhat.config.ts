import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";

const config: HardhatUserConfig = {
  networks: {
    testnet: {
      url: "https://rpc.sunscreen.tech/parasol",
      chainId: 574,
      accounts: ["<ENTER TESTNET PVT KEY>"]
    },
    local: {
      url: "http://127.0.0.1:8545",
      chainId: 31337,
      accounts: ["<ENTER LOCAL PVT KEY>"],
    },
  },
  solidity: {
    version: "0.8.19", // Use the appropriate Solidity version for your project
  },
  paths: {
    sources: "./src/",
  }
};

export default config;
