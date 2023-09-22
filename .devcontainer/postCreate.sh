#!/usr/bin/env bash

# NOTE: We are abusing a race condition here to get the some initial bash
# commands related to environmental variables set. The postCreateCommand is run
# and then the container is connected to, meaning that we have a small amount of
# time where this script is run and no editor terminal is created. We use this
# time to set custom container messages and set up a local copy of Rust.

# Terminal launch help message
read -r -d '' STARTUP_MESSAGE <<'EOF'
Welcome to the Parasol testnet! You can create new account credentials by running

cast wallet new

and get funds at https://faucet.sunscreen.tech.

Documentation can be found at https://hackathon.sunscreen.tech.
EOF

# Do not print out an initial message.
sudo echo "" > /workspaces/.codespaces/shared/first-run-notice.txt

# and instead always print out this information
echo "$STARTUP_MESSAGE" >> ~/.msg
echo "cat ~/.msg" >> ~/.bashrc


# Force the installation of the git submodules
git remote add origin https://github.com/Sunscreen-tech/parasol-hardhat-template.git
git branch --set-upstream-to=origin/main
git config pull.rebase true
git pull origin main
git submodule update --init --recursive

git remote remove origin

cd contracts
npm install
cd ../app/counter
npm install
