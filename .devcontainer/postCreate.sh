#!/usr/bin/env bash

# Force the installation of the git submodules
git remote add origin https://github.com/Sunscreen-tech/parasol-hardhat-template.git
git branch --set-upstream-to=origin/main
git config pull.rebase true
git pull
git submodule update --init --recursive

cd contracts
npm install
cd ../app/counter
npm install
