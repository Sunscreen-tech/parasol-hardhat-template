# Parasol Hardhat Monorepo Template
This repository includes a sample to:
1. Deploy a contract with FHE operations
2. Interact with it as a contract client (i.e. call functions as a user of the contract)

# Getting Started
You can deploy and interact with contracts via our testnet or install a single-node network on your dev machine to test locally.
First ensure the sub-modules are synced:
```sh
git submodule update --init --recursive
```

## Using The Test Network
The test network is deployed and available at: https://rpc.sunscreen.tech/parasol with Chain ID 574.

## Using `Anvil` as a local testnet
First, you'll need `cargo`; if you don't have it, the easiest way is to install via `rustup`:

```sh
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

If you are on linux, also run the following:
```sh
apt update
```
```sh
apt install pkg-config
```
```sh
apt install libssl-dev
```
```sh
apt install build-essential cmake clang git
```

Then you can install our foundry fork:

```sh
cargo install --git https://github.com/Sunscreen-tech/foundry --profile local forge cast anvil --locked
```

For more info on foundry, see the official
[docs](https://book.getfoundry.sh/).

To start your a local testnet:

```sh
anvil
```

Your network is ready! You will have 10 accounts and 10 private keys available for use. If you didn't change any defaults, your network should be available at http://127.0.0.1:8545 with Chain ID 31337.

## Install Node.JS dependencies
```bash
cd ./contracts & npm install
```
```bash
cd ./app/counter & npm install
```

# Deploying A Contract
The deployment code exists in the `contracts` folder. <br/>
The contract we will deploy exists under the `src` directory. It contains the `Counter.sol` contract, which is the one we are deploying. We suggest using this as a starting point to see how the process works before modifying it.

## To Anvil (local network)
#### Get test account
Simply run
```bash
anvil
```
and denote one of the account and private keys that get printed.

#### Set account
Go to `hardhat.config.ts` and add the private key for your account WITHOUT the '0x' prefix to the local account.
**NOTE** You need to put a valid private-key value for both, the testnet and local. Hardhat doesn't like it if the values are bad, even if unused.

#### Deploy
Then deploy your contract:
```bash
npx hardhat run --network local scripts/deploy.ts
```

## To the test network
#### Create an account
First, you'll need to create an account in your wallet and then, Visit the [faucet](https://faucet.sunscreen.tech/) to fund it.

Finally, denote your account's private key and address for deployment.

#### Set account
Go to `hardhat.config.ts` and add the private key for your account WITHOUT the '0x' prefix to the testnet account.

####Deploy
Then deploy your contract:
```bash
npx hardhat run --network testnet scripts/deploy.ts
```

# Interacting as A Client
```bash
cd app/counter
```
```bash
npm start
```

