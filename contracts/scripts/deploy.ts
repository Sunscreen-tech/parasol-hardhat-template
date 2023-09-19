import { ethers } from "hardhat";
const hre = require("hardhat");
const fs = require("fs");
async function main() {
  const ethProvider = new ethers.JsonRpcProvider(hre.network.config.url);
  const wallet = new ethers.Wallet(hre.network.config.accounts[0], ethProvider);

  //Library deployment
  console.log("Building bytes library");
  const bytesLib = await ethers.getContractFactory("Bytes", wallet);
  console.log("Deploying bytes library");
  const bytesLibInstance = await bytesLib.deploy();
  await bytesLibInstance.waitForDeployment();
  console.log("Bytes Library Address--->" + await bytesLibInstance.getAddress());

  console.log("Building FHE library");
  const fheLib = await ethers.getContractFactory("FHE", { signer: wallet });
  console.log("Deploying FHE library");
  const fheLibInstance = await fheLib.deploy();
  await fheLibInstance.waitForDeployment();
  console.log("FHE Library Address--->" + await fheLibInstance.getAddress());

  // Contract deployment
  console.log("Building contract");
  const Counter = await ethers.getContractFactory("Counter", {signer: wallet, libraries: { FHE: await fheLibInstance.getAddress() }  });

  console.log("Deploying contract");
  const counter = await Counter.deploy(5);

  await counter.waitForDeployment();
  console.log(
    `Contract deployed to ${await counter.getAddress()}`
  );

  // Write ABI and address to a JSON file
  const contractInfo = {
    address: await counter.getAddress(),
    abi: counter.interface,
  };
  const contractInfoJSON = JSON.stringify(contractInfo, null, 2);
  fs.writeFileSync("contractInfo.json", contractInfoJSON);

  console.log(`Contract information written to contractInfo.json`);
  fs.copyFile("contractInfo.json", "../app/counter/contractInfo.json", (err: any) => {
    if (err) {
      console.log("Error Found:", err);
    }
    else {

      console.log(`Contract information copied to app/counter/contractInfo.json`);
    }
  });

}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
