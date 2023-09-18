// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "./libs/FHE.sol";

contract Counter {
    bytes public number;

    constructor(uint256 seed) {
        number = FHE.encryptUint256(seed);
    }

    function setNumber(bytes calldata encryptedNumber) public {
        number = encryptedNumber;
    }

    function increment() public {
        number = FHE.addUint256EncPlain(FHE.networkPublicKey(), number, 1);
    }

    function getPublicKey() public view returns (bytes memory) {
      return FHE.networkPublicKey();
    }

    function getNumberSecretly(bytes memory publicKey) public view returns (bytes memory) {
        return FHE.reencryptUint256(publicKey, number);
    }
}