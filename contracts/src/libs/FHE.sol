// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "./Bytes.sol";

library FHE {
    using Bytes for *;

    // Gas costs, must match what is in the EVM precompile.
    uint256 public constant ADD_GAS = 200;
    uint256 public constant ADD_PLAIN_GAS = ADD_GAS;
    uint256 public constant SUBTRACT_GAS = ADD_GAS;
    uint256 public constant SUBTRACT_PLAIN_GAS = ADD_GAS;
    uint256 public constant MULTIPLY_GAS = 1000;
    uint256 public constant MULTIPLY_PLAIN_GAS = ADD_PLAIN_GAS;
    uint256 public constant ENCRYPT_GAS = 1000;
    uint256 public constant REENCRYPT_GAS = 2000;
    uint256 public constant DECRYPT_GAS = 1000;
    uint256 public constant NETWORK_PUBLIC_KEY_GAS = 0;

    // Precompile addresses
    uint256 public constant FHE_ADDRESS_NAMESPACE = 0xf0_00_00_00;
    uint256 public constant FHE_ADDRESS_UINT256_NAMESPACE = 0x00_00_00_00;
    uint256 public constant FHE_ADDRESS_UINT64_NAMESPACE = 0x00_00_01_00;
    uint256 public constant FHE_ADDRESS_INT64_NAMESPACE = 0x00_00_02_00;
    uint256 public constant FHE_ADDRESS_FRAC64_NAMESPACE = 0x00_00_03_00;

    uint256 public constant FHE_ADDRESS_ADD_NAMESPACE = 0x00_00_00_00;
    uint256 public constant FHE_ADDRESS_SUBTRACT_NAMESPACE = 0x00_00_00_10;
    uint256 public constant FHE_ADDRESS_MULTIPLY_NAMESPACE = 0x00_00_00_20;

    // Network API addresses
    uint256 public constant FHE_NETWORK_API_NAMESPACE = 0x01_00_00_00;

    uint256 public constant FHE_NETWORK_KEY_ADDRESS = 0x00_00_00_00;
    uint256 public constant FHE_ENCRYPT_ADDRESS = 0x00_00_00_10;
    uint256 public constant FHE_REENCRYPT_ADDRESS = 0x00_00_00_20;
    uint256 public constant FHE_DECRYPT_ADDRESS = 0x00_00_00_30;

    uint256 public constant FHE_NETWORK_PUBLIC_KEY_ADDRESS =
        FHE_ADDRESS_NAMESPACE | FHE_NETWORK_API_NAMESPACE | FHE_NETWORK_KEY_ADDRESS;

    // uint256
    uint256 public constant ADD_CIPHERUINT256CIPHERUINT256_ADDRESS =
        FHE_ADDRESS_NAMESPACE | FHE_ADDRESS_UINT256_NAMESPACE | FHE_ADDRESS_ADD_NAMESPACE | 0x00;
    uint256 public constant ADD_CIPHERUINT256UINT256_ADDRESS =
        FHE_ADDRESS_NAMESPACE | FHE_ADDRESS_UINT256_NAMESPACE | FHE_ADDRESS_ADD_NAMESPACE | 0x01;
    uint256 public constant ADD_UINT256CIPHERUINT256_ADDRESS =
        FHE_ADDRESS_NAMESPACE | FHE_ADDRESS_UINT256_NAMESPACE | FHE_ADDRESS_ADD_NAMESPACE | 0x02;

    uint256 public constant SUBTRACT_CIPHERUINT256CIPHERUINT256_ADDRESS =
        FHE_ADDRESS_NAMESPACE | FHE_ADDRESS_UINT256_NAMESPACE | FHE_ADDRESS_SUBTRACT_NAMESPACE | 0x00;
    uint256 public constant SUBTRACT_CIPHERUINT256UINT256_ADDRESS =
        FHE_ADDRESS_NAMESPACE | FHE_ADDRESS_UINT256_NAMESPACE | FHE_ADDRESS_SUBTRACT_NAMESPACE | 0x01;
    uint256 public constant SUBTRACT_UINT256CIPHERUINT256_ADDRESS =
        FHE_ADDRESS_NAMESPACE | FHE_ADDRESS_UINT256_NAMESPACE | FHE_ADDRESS_SUBTRACT_NAMESPACE | 0x02;

    uint256 public constant MULTIPLY_CIPHERUINT256CIPHERUINT256_ADDRESS =
        FHE_ADDRESS_NAMESPACE | FHE_ADDRESS_UINT256_NAMESPACE | FHE_ADDRESS_MULTIPLY_NAMESPACE | 0x00;
    uint256 public constant MULTIPLY_CIPHERUINT256UINT256_ADDRESS =
        FHE_ADDRESS_NAMESPACE | FHE_ADDRESS_UINT256_NAMESPACE | FHE_ADDRESS_MULTIPLY_NAMESPACE | 0x01;
    uint256 public constant MULTIPLY_UINT256CIPHERUINT256_ADDRESS =
        FHE_ADDRESS_NAMESPACE | FHE_ADDRESS_UINT256_NAMESPACE | FHE_ADDRESS_MULTIPLY_NAMESPACE | 0x02;

    uint256 public constant ENCRYPT_UINT256_ADDRESS =
        FHE_ADDRESS_NAMESPACE | FHE_NETWORK_API_NAMESPACE | FHE_ADDRESS_UINT256_NAMESPACE | FHE_ENCRYPT_ADDRESS;

    uint256 public constant REENCRYPT_UINT256_ADDRESS =
        FHE_ADDRESS_NAMESPACE | FHE_NETWORK_API_NAMESPACE | FHE_ADDRESS_UINT256_NAMESPACE | FHE_REENCRYPT_ADDRESS;

    uint256 public constant DECRYPT_UINT256_ADDRESS =
        FHE_ADDRESS_NAMESPACE | FHE_NETWORK_API_NAMESPACE | FHE_ADDRESS_UINT256_NAMESPACE | FHE_DECRYPT_ADDRESS;

    // uint64
    uint256 public constant ADD_CIPHERUINT64CIPHERUINT64_ADDRESS =
        FHE_ADDRESS_NAMESPACE | FHE_ADDRESS_UINT64_NAMESPACE | FHE_ADDRESS_ADD_NAMESPACE | 0x00;
    uint256 public constant ADD_CIPHERUINT64UINT64_ADDRESS =
        FHE_ADDRESS_NAMESPACE | FHE_ADDRESS_UINT64_NAMESPACE | FHE_ADDRESS_ADD_NAMESPACE | 0x01;
    uint256 public constant ADD_UINT64CIPHERUINT64_ADDRESS =
        FHE_ADDRESS_NAMESPACE | FHE_ADDRESS_UINT64_NAMESPACE | FHE_ADDRESS_ADD_NAMESPACE | 0x02;

    uint256 public constant SUBTRACT_CIPHERUINT64CIPHERUINT64_ADDRESS =
        FHE_ADDRESS_NAMESPACE | FHE_ADDRESS_UINT64_NAMESPACE | FHE_ADDRESS_SUBTRACT_NAMESPACE | 0x00;
    uint256 public constant SUBTRACT_CIPHERUINT64UINT64_ADDRESS =
        FHE_ADDRESS_NAMESPACE | FHE_ADDRESS_UINT64_NAMESPACE | FHE_ADDRESS_SUBTRACT_NAMESPACE | 0x01;
    uint256 public constant SUBTRACT_UINT64CIPHERUINT64_ADDRESS =
        FHE_ADDRESS_NAMESPACE | FHE_ADDRESS_UINT64_NAMESPACE | FHE_ADDRESS_SUBTRACT_NAMESPACE | 0x02;

    uint256 public constant MULTIPLY_CIPHERUINT64CIPHERUINT64_ADDRESS =
        FHE_ADDRESS_NAMESPACE | FHE_ADDRESS_UINT64_NAMESPACE | FHE_ADDRESS_MULTIPLY_NAMESPACE | 0x00;
    uint256 public constant MULTIPLY_CIPHERUINT64UINT64_ADDRESS =
        FHE_ADDRESS_NAMESPACE | FHE_ADDRESS_UINT64_NAMESPACE | FHE_ADDRESS_MULTIPLY_NAMESPACE | 0x01;
    uint256 public constant MULTIPLY_UINT64CIPHERUINT64_ADDRESS =
        FHE_ADDRESS_NAMESPACE | FHE_ADDRESS_UINT64_NAMESPACE | FHE_ADDRESS_MULTIPLY_NAMESPACE | 0x02;

    uint256 public constant ENCRYPT_UINT64_ADDRESS =
        FHE_ADDRESS_NAMESPACE | FHE_NETWORK_API_NAMESPACE | FHE_ADDRESS_UINT64_NAMESPACE | FHE_ENCRYPT_ADDRESS;

    uint256 public constant REENCRYPT_UINT64_ADDRESS =
        FHE_ADDRESS_NAMESPACE | FHE_NETWORK_API_NAMESPACE | FHE_ADDRESS_UINT64_NAMESPACE | FHE_REENCRYPT_ADDRESS;

    uint256 public constant DECRYPT_UINT64_ADDRESS =
        FHE_ADDRESS_NAMESPACE | FHE_NETWORK_API_NAMESPACE | FHE_ADDRESS_UINT64_NAMESPACE | FHE_DECRYPT_ADDRESS;

    // int64
    uint256 public constant ADD_CIPHERINT64CIPHERINT64_ADDRESS =
        FHE_ADDRESS_NAMESPACE | FHE_ADDRESS_INT64_NAMESPACE | FHE_ADDRESS_ADD_NAMESPACE | 0x00;
    uint256 public constant ADD_CIPHERINT64INT64_ADDRESS =
        FHE_ADDRESS_NAMESPACE | FHE_ADDRESS_INT64_NAMESPACE | FHE_ADDRESS_ADD_NAMESPACE | 0x01;
    uint256 public constant ADD_INT64CIPHERINT64_ADDRESS =
        FHE_ADDRESS_NAMESPACE | FHE_ADDRESS_INT64_NAMESPACE | FHE_ADDRESS_ADD_NAMESPACE | 0x02;

    uint256 public constant SUBTRACT_CIPHERINT64CIPHERINT64_ADDRESS =
        FHE_ADDRESS_NAMESPACE | FHE_ADDRESS_INT64_NAMESPACE | FHE_ADDRESS_SUBTRACT_NAMESPACE | 0x00;
    uint256 public constant SUBTRACT_CIPHERINT64INT64_ADDRESS =
        FHE_ADDRESS_NAMESPACE | FHE_ADDRESS_INT64_NAMESPACE | FHE_ADDRESS_SUBTRACT_NAMESPACE | 0x01;
    uint256 public constant SUBTRACT_INT64CIPHERINT64_ADDRESS =
        FHE_ADDRESS_NAMESPACE | FHE_ADDRESS_INT64_NAMESPACE | FHE_ADDRESS_SUBTRACT_NAMESPACE | 0x02;

    uint256 public constant MULTIPLY_CIPHERINT64CIPHERINT64_ADDRESS =
        FHE_ADDRESS_NAMESPACE | FHE_ADDRESS_INT64_NAMESPACE | FHE_ADDRESS_MULTIPLY_NAMESPACE | 0x00;
    uint256 public constant MULTIPLY_CIPHERINT64INT64_ADDRESS =
        FHE_ADDRESS_NAMESPACE | FHE_ADDRESS_INT64_NAMESPACE | FHE_ADDRESS_MULTIPLY_NAMESPACE | 0x01;
    uint256 public constant MULTIPLY_INT64CIPHERINT64_ADDRESS =
        FHE_ADDRESS_NAMESPACE | FHE_ADDRESS_INT64_NAMESPACE | FHE_ADDRESS_MULTIPLY_NAMESPACE | 0x02;

    uint256 public constant ENCRYPT_INT64_ADDRESS =
        FHE_ADDRESS_NAMESPACE | FHE_NETWORK_API_NAMESPACE | FHE_ADDRESS_INT64_NAMESPACE | FHE_ENCRYPT_ADDRESS;

    uint256 public constant REENCRYPT_INT64_ADDRESS =
        FHE_ADDRESS_NAMESPACE | FHE_NETWORK_API_NAMESPACE | FHE_ADDRESS_INT64_NAMESPACE | FHE_REENCRYPT_ADDRESS;

    uint256 public constant DECRYPT_INT64_ADDRESS =
        FHE_ADDRESS_NAMESPACE | FHE_NETWORK_API_NAMESPACE | FHE_ADDRESS_INT64_NAMESPACE | FHE_DECRYPT_ADDRESS;

    // frac64
    uint256 public constant ADD_CIPHERFRAC64CIPHERFRAC64_ADDRESS =
        FHE_ADDRESS_NAMESPACE | FHE_ADDRESS_FRAC64_NAMESPACE | FHE_ADDRESS_ADD_NAMESPACE | 0x00;
    uint256 public constant ADD_CIPHERFRAC64FRAC64_ADDRESS =
        FHE_ADDRESS_NAMESPACE | FHE_ADDRESS_FRAC64_NAMESPACE | FHE_ADDRESS_ADD_NAMESPACE | 0x01;
    uint256 public constant ADD_FRAC64CIPHERFRAC64_ADDRESS =
        FHE_ADDRESS_NAMESPACE | FHE_ADDRESS_FRAC64_NAMESPACE | FHE_ADDRESS_ADD_NAMESPACE | 0x02;

    uint256 public constant SUBTRACT_CIPHERFRAC64CIPHERFRAC64_ADDRESS =
        FHE_ADDRESS_NAMESPACE | FHE_ADDRESS_FRAC64_NAMESPACE | FHE_ADDRESS_SUBTRACT_NAMESPACE | 0x00;
    uint256 public constant SUBTRACT_CIPHERFRAC64FRAC64_ADDRESS =
        FHE_ADDRESS_NAMESPACE | FHE_ADDRESS_FRAC64_NAMESPACE | FHE_ADDRESS_SUBTRACT_NAMESPACE | 0x01;
    uint256 public constant SUBTRACT_FRAC64CIPHERFRAC64_ADDRESS =
        FHE_ADDRESS_NAMESPACE | FHE_ADDRESS_FRAC64_NAMESPACE | FHE_ADDRESS_SUBTRACT_NAMESPACE | 0x02;

    uint256 public constant MULTIPLY_CIPHERFRAC64CIPHERFRAC64_ADDRESS =
        FHE_ADDRESS_NAMESPACE | FHE_ADDRESS_FRAC64_NAMESPACE | FHE_ADDRESS_MULTIPLY_NAMESPACE | 0x00;
    uint256 public constant MULTIPLY_CIPHERFRAC64FRAC64_ADDRESS =
        FHE_ADDRESS_NAMESPACE | FHE_ADDRESS_FRAC64_NAMESPACE | FHE_ADDRESS_MULTIPLY_NAMESPACE | 0x01;
    uint256 public constant MULTIPLY_FRAC64CIPHERFRAC64_ADDRESS =
        FHE_ADDRESS_NAMESPACE | FHE_ADDRESS_FRAC64_NAMESPACE | FHE_ADDRESS_MULTIPLY_NAMESPACE | 0x02;

    uint256 public constant ENCRYPT_FRAC64_ADDRESS =
        FHE_ADDRESS_NAMESPACE | FHE_NETWORK_API_NAMESPACE | FHE_ADDRESS_FRAC64_NAMESPACE | FHE_ENCRYPT_ADDRESS;

    uint256 public constant REENCRYPT_FRAC64_ADDRESS =
        FHE_ADDRESS_NAMESPACE | FHE_NETWORK_API_NAMESPACE | FHE_ADDRESS_FRAC64_NAMESPACE | FHE_REENCRYPT_ADDRESS;

    uint256 public constant DECRYPT_FRAC64_ADDRESS =
        FHE_ADDRESS_NAMESPACE | FHE_NETWORK_API_NAMESPACE | FHE_ADDRESS_FRAC64_NAMESPACE | FHE_DECRYPT_ADDRESS;

    /**
     *
     * Packing variants
     *
     */

    /// Pack values for a binary operation on two encrypted values
    /// @param pubk Bincode encoded `Sunscreen::PublicKey`
    /// @param encryptedA Encrypted value of the left input to the binary
    ///                   operator. Can be any `Sunscreen::Cipher` compatible
    ///                   type.
    /// @param encryptedB Encrypted value of the right input to the binary
    ///                   operator. Can be any `Sunscreen::Cipher` compatible
    ///                   type.
    function packEnc(bytes memory pubk, bytes memory encryptedA, bytes memory encryptedB)
        internal
        pure
        returns (bytes memory)
    {
        bytes memory input;
        uint256 offsetsLength = 8; // 2 u32s
        uint256 offset_1 = pubk.length + offsetsLength;
        uint256 offset_2 = offset_1 + encryptedA.length;
        require(offset_1 <= type(uint32).max, "pubk argument too large");
        require(offset_2 <= type(uint32).max, "a argument too large");

        bytes memory offset_1be = offset_1.toBytes(32);
        bytes memory offset_2be = offset_2.toBytes(32);
        input = bytes.concat(offset_1be, offset_2be, pubk, encryptedA, encryptedB);

        return input;
    }

    /// Pack values for a binary operation of an encrypted uint256 value with a
    /// plaintext uint256 value, where the plaintext value is on the right.
    /// @param pubk Bincode encoded `Sunscreen::PublicKey`
    /// @param encryptedValue Encrypted value to the binary operator. Bincode encoded
    ///                       `Sunscreen::Cipher<bfv::Unsigned256>`.
    /// @param plaintextValue Plaintext value to the binary operator.
    function packUint256EncPlain(bytes memory pubk, bytes memory encryptedValue, uint256 plaintextValue)
        internal
        pure
        returns (bytes memory)
    {
        bytes memory input;
        uint256 offsetLength = 8; // 2 u32s
        uint256 offset_1 = pubk.length + offsetLength;
        uint256 offset_2 = offset_1 + encryptedValue.length;
        require(offset_1 <= type(uint32).max, "pubk argument too large");
        require(offset_2 <= type(uint32).max, "a argument too large");

        bytes memory byteEncodedValue = plaintextValue.toBytes();
        bytes memory offset_1be = offset_1.toBytes(32);
        bytes memory offset_2be = offset_2.toBytes(32);

        input = bytes.concat(offset_1be, offset_2be, pubk, encryptedValue, byteEncodedValue);

        return input;
    }

    /// Pack values for a binary operation of an encrypted uint256 value with a
    /// plaintext uint256 value, where the plaintext value is on the left.
    /// @param pubk Bincode encoded `Sunscreen::PublicKey`
    /// @param plaintextValue Plaintext value to the binary operator.
    /// @param encryptedValue Encrypted value to the binary operator. Bincode encoded
    ///                       `Sunscreen::Cipher<bfv::Unsigned256>`.
    function packUint256PlainEnc(bytes memory pubk, uint256 plaintextValue, bytes memory encryptedValue)
        internal
        pure
        returns (bytes memory)
    {
        bytes memory input;
        uint256 offsetLength = 8; // 2 u32s
        uint256 offset_1 = pubk.length + offsetLength;
        uint256 offset_2 = offset_1 + 32; // 32 bytes for the plaintext value
        require(offset_1 <= type(uint32).max, "pubk argument too large");
        require(offset_2 <= type(uint32).max, "a argument too large");

        bytes memory byteEncodedValue = plaintextValue.toBytes();
        bytes memory offset_1be = offset_1.toBytes(32);
        bytes memory offset_2be = offset_2.toBytes(32);

        input = bytes.concat(offset_1be, offset_2be, pubk, byteEncodedValue, encryptedValue);

        return input;
    }

    /// Pack values for encryption function call.
    /// @param plaintextValue Plaintext value to the binary operator.
    /// @param data Bytes to append to the message
    function packUint256Bytes(uint256 plaintextValue, bytes memory data) internal pure returns (bytes memory) {
        bytes memory input;
        uint256 offsetLength = 4; // 1 u32s
        uint256 offset_1 = 32 + offsetLength;
        require(offset_1 <= type(uint32).max, "pubk argument too large");

        bytes memory byteEncodedValue = plaintextValue.toBytes();
        bytes memory offset_1be = offset_1.toBytes(32);

        input = bytes.concat(offset_1be, byteEncodedValue, data);

        return input;
    }

    /// Pack values for a binary operation of an encrypted uint64 value with a
    /// plaintext uint64 value, where the plaintext value is on the right.
    /// @param pubk Bincode encoded `Sunscreen::PublicKey`
    /// @param encryptedValue Encrypted value to the binary operator. Bincode encoded
    ///                       `Sunscreen::Cipher<bfv::Unsigned64>`.
    /// @param plaintextValue Plaintext value to the binary operator.
    function packUint64EncPlain(bytes memory pubk, bytes memory encryptedValue, uint64 plaintextValue)
        internal
        pure
        returns (bytes memory)
    {
        bytes memory input;
        uint256 offsetLength = 8; // 2 u32s
        uint256 offset_1 = pubk.length + offsetLength;
        uint256 offset_2 = offset_1 + encryptedValue.length;
        require(offset_1 <= type(uint32).max, "pubk argument too large");
        require(offset_2 <= type(uint32).max, "a argument too large");

        bytes memory byteEncodedValue = plaintextValue.toBytes(64);
        bytes memory offset_1be = offset_1.toBytes(32);
        bytes memory offset_2be = offset_2.toBytes(32);

        input = bytes.concat(offset_1be, offset_2be, pubk, encryptedValue, byteEncodedValue);

        return input;
    }

    /// Pack values for a binary operation of an encrypted uint64 value with a
    /// plaintext uint64 value, where the plaintext value is on the left.
    /// @param pubk Bincode encoded `Sunscreen::PublicKey`
    /// @param plaintextValue Plaintext value to the binary operator.
    /// @param encryptedValue Encrypted value to the binary operator. Bincode encoded
    ///                       `Sunscreen::Cipher<bfv::Unsigned64>`.
    function packUint64PlainEnc(bytes memory pubk, uint64 plaintextValue, bytes memory encryptedValue)
        internal
        pure
        returns (bytes memory)
    {
        bytes memory input;
        uint256 offsetLength = 8; // 2 u32s
        uint256 offset_1 = pubk.length + offsetLength;
        uint256 offset_2 = offset_1 + 8; // 8 bytes for the plaintext value
        require(offset_1 <= type(uint32).max, "pubk argument too large");
        require(offset_2 <= type(uint32).max, "a argument too large");

        bytes memory byteEncodedValue = plaintextValue.toBytes(64);
        bytes memory offset_1be = offset_1.toBytes(32);
        bytes memory offset_2be = offset_2.toBytes(32);

        input = bytes.concat(offset_1be, offset_2be, pubk, byteEncodedValue, encryptedValue);

        return input;
    }

    /// Pack values for encryption function call.
    /// @param plaintextValue Plaintext value to the binary operator.
    /// @param data Bytes to append to the message
    function packUint64Bytes(uint64 plaintextValue, bytes memory data) internal pure returns (bytes memory) {
        bytes memory input;
        uint256 offsetLength = 4; // 1 u32s
        uint256 offset_1 = 8 + offsetLength;
        require(offset_1 <= type(uint32).max, "pubk argument too large");

        bytes memory byteEncodedValue = plaintextValue.toBytes(64);
        bytes memory offset_1be = offset_1.toBytes(32);

        input = bytes.concat(offset_1be, byteEncodedValue, data);

        return input;
    }

    /// Pack values for a binary operation of an encrypted int64 value with a
    /// plaintext int64 value, where the plaintext value is on the right.
    /// @param pubk Bincode encoded `Sunscreen::PublicKey`
    /// @param encryptedValue Encrypted value to the binary operator. Bincode encoded
    ///                       `Sunscreen::Cipher<bfv::Signed>`.
    /// @param plaintextValue Plaintext value to the binary operator.
    function packInt64EncPlain(bytes memory pubk, bytes memory encryptedValue, int64 plaintextValue)
        internal
        pure
        returns (bytes memory)
    {
        bytes memory input;
        uint256 offsetLength = 8; // 2 u32s
        uint256 offset_1 = pubk.length + offsetLength;
        uint256 offset_2 = offset_1 + encryptedValue.length;
        require(offset_1 <= type(uint32).max, "pubk argument too large");
        require(offset_2 <= type(uint32).max, "a argument too large");

        bytes memory byteEncodedValue = plaintextValue.toBytes();
        bytes memory offset_1be = offset_1.toBytes(32);
        bytes memory offset_2be = offset_2.toBytes(32);

        input = bytes.concat(offset_1be, offset_2be, pubk, encryptedValue, byteEncodedValue);

        return input;
    }

    /// Pack values for a binary operation of an encrypted int64 value with a
    /// plaintext int64 value, where the plaintext value is on the left.
    /// @param pubk Bincode encoded `Sunscreen::PublicKey`
    /// @param plaintextValue Plaintext value to the binary operator.
    /// @param encryptedValue Encrypted value to the binary operator. Bincode encoded
    ///                       `Sunscreen::Cipher<bfv::Signed>`.
    function packInt64PlainEnc(bytes memory pubk, int64 plaintextValue, bytes memory encryptedValue)
        internal
        pure
        returns (bytes memory)
    {
        bytes memory input;
        uint256 offsetLength = 8; // 2 u32s
        uint256 offset_1 = pubk.length + offsetLength;
        uint256 offset_2 = offset_1 + 8; // 8 bytes for the plaintext value
        require(offset_1 <= type(uint32).max, "pubk argument too large");
        require(offset_2 <= type(uint32).max, "a argument too large");

        bytes memory byteEncodedValue = plaintextValue.toBytes();
        bytes memory offset_1be = offset_1.toBytes(32);
        bytes memory offset_2be = offset_2.toBytes(32);

        input = bytes.concat(offset_1be, offset_2be, pubk, byteEncodedValue, encryptedValue);

        return input;
    }

    /// Pack values for encryption function call.
    /// @param plaintextValue Plaintext value to the binary operator.
    /// @param data Bytes to append to the message
    function packInt64Bytes(int64 plaintextValue, bytes memory data) internal pure returns (bytes memory) {
        bytes memory input;
        uint256 offsetLength = 4; // 1 u32s
        uint256 offset_1 = 8 + offsetLength;
        require(offset_1 <= type(uint32).max, "pubk argument too large");

        bytes memory byteEncodedValue = plaintextValue.toBytes();
        bytes memory offset_1be = offset_1.toBytes(32);

        input = bytes.concat(offset_1be, byteEncodedValue, data);

        return input;
    }

    /// Pack values for a binary operation of an encrypted Fractional<64> value with a
    /// plaintext Fractional<64> value, where the plaintext value is on the right.
    /// @param pubk Bincode encoded `Sunscreen::PublicKey`
    /// @param encryptedValue Encrypted value to the binary operator. Bincode encoded
    ///                       `Sunscreen::Cipher<bfv::Fractional<64>>`.
    /// @param plaintextValue Plaintext value to the binary operator.
    function packFrac64EncPlain(bytes memory pubk, bytes memory encryptedValue, bytes8 plaintextValue)
        internal
        pure
        returns (bytes memory)
    {
        bytes memory input;
        uint256 offsetLength = 8; // 2 u32s
        uint256 offset_1 = pubk.length + offsetLength;
        uint256 offset_2 = offset_1 + encryptedValue.length;
        require(offset_1 <= type(uint32).max, "pubk argument too large");
        require(offset_2 <= type(uint32).max, "a argument too large");

        bytes memory byteEncodedValue = plaintextValue.toBytes();
        bytes memory offset_1be = offset_1.toBytes(32);
        bytes memory offset_2be = offset_2.toBytes(32);

        input = bytes.concat(offset_1be, offset_2be, pubk, encryptedValue, byteEncodedValue);

        return input;
    }

    /// Pack values for a binary operation of an encrypted Fractional<64> value
    /// with a plaintext Fractional<64> value, where the plaintext value is on
    /// the left.
    /// @param pubk Bincode encoded `Sunscreen::PublicKey`
    /// @param plaintextValue Plaintext value to the binary operator.
    /// @param encryptedValue Encrypted value to the binary operator. Bincode encoded
    ///                       `Sunscreen::Cipher<bfv::Fractional<64>>`.
    function packFrac64PlainEnc(bytes memory pubk, bytes8 plaintextValue, bytes memory encryptedValue)
        internal
        pure
        returns (bytes memory)
    {
        bytes memory input;
        uint256 offsetLength = 8; // 2 u32s
        uint256 offset_1 = pubk.length + offsetLength;
        uint256 offset_2 = offset_1 + plaintextValue.length; // 8 bytes for the plaintext value
        require(offset_1 <= type(uint32).max, "pubk argument too large");
        require(offset_2 <= type(uint32).max, "a argument too large");

        bytes memory byteEncodedValue = plaintextValue.toBytes();
        bytes memory offset_1be = offset_1.toBytes(32);
        bytes memory offset_2be = offset_2.toBytes(32);

        input = bytes.concat(offset_1be, offset_2be, pubk, byteEncodedValue, encryptedValue);

        return input;
    }

    /// Pack values for encryption function call.
    /// @param plaintextValue Plaintext value to the binary operator.
    /// @param data Bytes to append to the message
    function packFrac64Bytes(bytes8 plaintextValue, bytes memory data) internal pure returns (bytes memory) {
        bytes memory input;
        uint256 offsetLength = 4; // 1 u32s
        uint256 offset_1 = 8 + offsetLength;
        require(offset_1 <= type(uint32).max, "pubk argument too large");

        bytes memory byteEncodedValue = plaintextValue.toBytes();
        bytes memory offset_1be = offset_1.toBytes(32);

        input = bytes.concat(offset_1be, byteEncodedValue, data);

        return input;
    }

    /**
     *
     * Call variants
     *
     */

    /// Call a FHE precompile function
    /// @param _address The address of the precompile.
    /// @param gasCost How much gas it costs to run this precompile.
    /// @param input The input to the precompile packed as a byte string.
    function callPrecompile(uint256 _address, uint256 gasCost, bytes memory input)
        internal
        view
        returns (bytes memory)
    {
        bytes memory output;
        bool success;

        assembly {
            // 32 bytes at the start of input hold its length, hence
            // 1. we add 32 to point to the start of the actual input data
            // 2. we mload(input) to get the size of the input data

            // EVM precompile contract addresses listed here: https://www.evm.codes/precompiled?fork=merge
            // See https://www.evm.codes/#fa?fork=merge for staticcall details
            success :=
                staticcall(
                    gasCost,
                    _address,
                    add(input, 32), // argOffset
                    mload(input), // argSize
                    0, // retOffset
                    0 // retSize
                )
            let size := returndatasize()

            // Get a pointer to some free space in memory. This information is
            // always located at 0x40. See
            // https://blog.trustlook.com/understand-evm-bytecode-part-4/
            output := mload(0x40) // Get the free memory pointer

            // Update the free memory pointer to point to the next free memory
            // slot.
            mstore(0x40, add(output, add(0x20, size)))

            // Dynamic bytes store their size in the first 32 bytes of the data,
            // so we need to copy that over.
            mstore(output, size)

            // Copy the data from the return data to the output, starting at the
            // address of the output + 32 bytes (to skip the size)
            returndatacopy(add(output, 0x20), 0, size)
        }

        require(success, "Precompile call failed");
        return output;
    }

    /// Call a binary operation on two encrypted values
    /// @param _address The address of the precompile.
    /// @param gasCost How much gas it costs to run this precompile.
    /// @param pubk Bincode encoded `Sunscreen::PublicKey`
    /// @param encryptedA Encrypted value of the left input to the binary
    ///                   operator. This is any value that is compatible with
    ///                   the `Sunscreen::Cipher` type.
    /// @param encryptedB Encrypted value of the right input to the binary
    ///                   operator. This is any value that is compatible with
    ///                   the `Sunscreen::Cipher` type.
    function callEnc(
        uint256 _address,
        uint256 gasCost,
        bytes memory pubk,
        bytes memory encryptedA,
        bytes memory encryptedB
    ) internal view returns (bytes memory) {
        bytes memory input = packEnc(pubk, encryptedA, encryptedB);
        return bytes(callPrecompile(_address, gasCost, input));
    }

    /// Call a binary operation of an encrypted uint256 value with a plaintext
    /// uint256 value, where the plaintext value is on the right.
    /// @param _address The address of the precompile.
    /// @param gasCost How much gas it costs to run this precompile.
    /// @param pubk Bincode encoded `Sunscreen::PublicKey`
    /// @param encryptedValue Encrypted value to the binary operator. Bincode
    ///                       encoded `Sunscreen::Cipher<bfv::Unsigned256>`.
    /// @param plaintextValue Plaintext value to the binary operator.
    function callUint256EncPlain(
        uint256 _address,
        uint256 gasCost,
        bytes memory pubk,
        bytes memory encryptedValue,
        uint256 plaintextValue
    ) internal view returns (bytes memory) {
        bytes memory input = packUint256EncPlain(pubk, encryptedValue, plaintextValue);
        return bytes(callPrecompile(_address, gasCost, input));
    }

    /// Call a binary operation of an encrypted uint256 value with a plaintext
    /// uint256 value, where the plaintext value is on the left.
    /// @param _address The address of the precompile.
    /// @param gasCost How much gas it costs to run this precompile.
    /// @param pubk Bincode encoded `Sunscreen::PublicKey`
    /// @param plaintextValue Plaintext value to the binary operator.
    /// @param encryptedValue Encrypted value to the binary operator. Bincode
    ///                       encoded `Sunscreen::Cipher<bfv::Unsigned256>`.
    function callUint256PlainEnc(
        uint256 _address,
        uint256 gasCost,
        bytes memory pubk,
        uint256 plaintextValue,
        bytes memory encryptedValue
    ) internal view returns (bytes memory) {
        bytes memory input = packUint256PlainEnc(pubk, plaintextValue, encryptedValue);
        return bytes(callPrecompile(_address, gasCost, input));
    }

    /// Call a binary operation of an encrypted uint64 value with a plaintext
    /// uint64 value, where the plaintext value is on the right.
    /// @param _address The address of the precompile.
    /// @param gasCost How much gas it costs to run this precompile.
    /// @param pubk Bincode encoded `Sunscreen::PublicKey`
    /// @param encryptedValue Encrypted value to the binary operator. Bincode
    ///                       encoded `Sunscreen::Cipher<bfv::Unsigned64>`.
    /// @param plaintextValue Plaintext value to the binary operator.
    function callUint64EncPlain(
        uint256 _address,
        uint256 gasCost,
        bytes memory pubk,
        bytes memory encryptedValue,
        uint64 plaintextValue
    ) internal view returns (bytes memory) {
        bytes memory input = packUint64EncPlain(pubk, encryptedValue, plaintextValue);
        return bytes(callPrecompile(_address, gasCost, input));
    }

    /// Call a binary operation of an encrypted uint64 value with a plaintext
    /// uint64 value, where the plaintext value is on the left.
    /// @param _address The address of the precompile.
    /// @param gasCost How much gas it costs to run this precompile.
    /// @param pubk Bincode encoded `Sunscreen::PublicKey`
    /// @param plaintextValue Plaintext value to the binary operator.
    /// @param encryptedValue Encrypted value to the binary operator. Bincode
    ///                       encoded `Sunscreen::Cipher<bfv::Unsigned64>`.
    function callUint64PlainEnc(
        uint256 _address,
        uint256 gasCost,
        bytes memory pubk,
        uint64 plaintextValue,
        bytes memory encryptedValue
    ) internal view returns (bytes memory) {
        bytes memory input = packUint64PlainEnc(pubk, plaintextValue, encryptedValue);
        return bytes(callPrecompile(_address, gasCost, input));
    }

    /// Call a binary operation of an encrypted int64 value with a plaintext
    /// int64 value, where the plaintext value is on the right.
    /// @param _address The address of the precompile.
    /// @param gasCost How much gas it costs to run this precompile.
    /// @param pubk Bincode encoded `Sunscreen::PublicKey`
    /// @param encryptedValue Encrypted value to the binary operator. Bincode
    ///                       encoded `Sunscreen::Cipher<bfv::Signed>`.
    /// @param plaintextValue Plaintext value to the binary operator.
    function callInt64EncPlain(
        uint256 _address,
        uint256 gasCost,
        bytes memory pubk,
        bytes memory encryptedValue,
        int64 plaintextValue
    ) internal view returns (bytes memory) {
        bytes memory input = packInt64EncPlain(pubk, encryptedValue, plaintextValue);
        return callPrecompile(_address, gasCost, input);
    }

    /// Call a binary operation of an encrypted int64 value with a plaintext
    /// int64 value, where the plaintext value is on the left.
    /// @param _address The address of the precompile.
    /// @param gasCost How much gas it costs to run this precompile.
    /// @param pubk Bincode encoded `Sunscreen::PublicKey`
    /// @param plaintextValue Plaintext value to the binary operator.
    /// @param encryptedValue Encrypted value to the binary operator. Bincode
    ///                       encoded `Sunscreen::Cipher<bfv::Signed>`.
    function callInt64PlainEnc(
        uint256 _address,
        uint256 gasCost,
        bytes memory pubk,
        int64 plaintextValue,
        bytes memory encryptedValue
    ) internal view returns (bytes memory) {
        bytes memory input = packInt64PlainEnc(pubk, plaintextValue, encryptedValue);
        return callPrecompile(_address, gasCost, input);
    }

    /// Call a binary operation of an encrypted Fractional<64> value with a
    /// Fractional<64> plaintext value, where the plaintext value is on the
    /// right.
    /// @param _address The address of the precompile.
    /// @param gasCost How much gas it costs to run this precompile.
    /// @param pubk Bincode encoded `Sunscreen::PublicKey`
    /// @param encryptedValue Encrypted value to the binary operator. Bincode
    ///                       encoded `Sunscreen::Cipher<bfv::Fractional<64>>`.
    /// @param plaintextValue Plaintext value to the binary operator.
    function callFrac64EncPlain(
        uint256 _address,
        uint256 gasCost,
        bytes memory pubk,
        bytes memory encryptedValue,
        bytes8 plaintextValue
    ) internal view returns (bytes memory) {
        bytes memory input = packFrac64EncPlain(pubk, encryptedValue, plaintextValue);
        return callPrecompile(_address, gasCost, input);
    }

    /// Call a binary operation of an encrypted Fractional<64> value with a
    /// plaintext Fractional<64> value, where the plaintext value is on the
    /// left.
    /// @param _address The address of the precompile.
    /// @param gasCost How much gas it costs to run this precompile.
    /// @param pubk Bincode encoded `Sunscreen::PublicKey`
    /// @param plaintextValue Plaintext value to the binary operator.
    /// @param encryptedValue Encrypted value to the binary operator. Bincode
    ///                       encoded `Sunscreen::Cipher<bfv::Fractional<64>>`.
    function callFrac64PlainEnc(
        uint256 _address,
        uint256 gasCost,
        bytes memory pubk,
        bytes8 plaintextValue,
        bytes memory encryptedValue
    ) internal view returns (bytes memory) {
        bytes memory input = packFrac64PlainEnc(pubk, plaintextValue, encryptedValue);
        return callPrecompile(_address, gasCost, input);
    }

    /**
     *
     * uint256 operations
     *
     */

    /// Add two encrypted values
    /// @dev This costs 200 gas
    /// @param pubk Bincode encoded `Sunscreen::PublicKey`
    /// @param a Bincode encoded `Sunscreen::Cipher<bfv::Unsigned256>`.
    /// @param b Bincode encoded `Sunscreen::Cipher<bfv::Unsigned256>`.
    /// @return result The encrypted sum `a + b`.
    function addUint256EncEnc(bytes memory pubk, bytes memory a, bytes memory b) public view returns (bytes memory) {
        return callEnc(ADD_CIPHERUINT256CIPHERUINT256_ADDRESS, ADD_GAS, pubk, a, b);
    }

    /// Add an encrypted and plaintext value
    /// @dev This costs 200 gas
    /// @param pubk Bincode encoded `Sunscreen::PublicKey`
    /// @param encryptedValue Bincode encoded `Sunscreen::Cipher<bfv::Unsigned256>`.
    /// @param plaintextValue Plaintext value to add to a ciphertext
    /// @return result The encrypted sum `encryptedValue + plaintextValue`.
    function addUint256EncPlain(bytes memory pubk, bytes memory encryptedValue, uint256 plaintextValue)
        public
        view
        returns (bytes memory)
    {
        return
            callUint256EncPlain(ADD_CIPHERUINT256UINT256_ADDRESS, ADD_PLAIN_GAS, pubk, encryptedValue, plaintextValue);
    }

    /// Add a plaintext and encrypted value
    /// @dev This costs 200 gas
    /// @param pubk Bincode encoded `Sunscreen::PublicKey`
    /// @param plaintextValue Plaintext value to add to a ciphertext
    /// @param encryptedValue Bincode encoded `Sunscreen::Cipher<bfv::Unsigned256>`.
    /// @return result The encrypted sum `plaintextValue  + encryptedValue`.
    function addUint256PlainEnc(bytes memory pubk, uint256 plaintextValue, bytes memory encryptedValue)
        public
        view
        returns (bytes memory)
    {
        return
            callUint256PlainEnc(ADD_UINT256CIPHERUINT256_ADDRESS, ADD_PLAIN_GAS, pubk, plaintextValue, encryptedValue);
    }

    /// Subtract two encrypted values
    /// @dev This costs 200 gas
    /// @param pubk Bincode encoded `Sunscreen::PublicKey`
    /// @param a Bincode encoded `Sunscreen::Cipher<bfv::Unsigned256>`.
    /// @param b Bincode encoded `Sunscreen::Cipher<bfv::Unsigned256>`.
    /// @return result The encrypted subtraction `a - b`.
    function subtractUint256EncEnc(bytes memory pubk, bytes memory a, bytes memory b)
        public
        view
        returns (bytes memory)
    {
        return callEnc(SUBTRACT_CIPHERUINT256CIPHERUINT256_ADDRESS, SUBTRACT_GAS, pubk, a, b);
    }

    /// Subtract an encrypted and plaintext value
    /// @dev This costs 200 gas
    /// @param pubk Bincode encoded `Sunscreen::PublicKey`
    /// @param encryptedValue Bincode encoded `Sunscreen::Cipher<bfv::Unsigned256>`.
    /// @param plaintextValue Plaintext value to subtract from a ciphertext
    /// @return result The encrypted subtraction `encryptedValue - plaintextValue`.
    function subtractUint256EncPlain(bytes memory pubk, bytes memory encryptedValue, uint256 plaintextValue)
        public
        view
        returns (bytes memory)
    {
        return callUint256EncPlain(
            SUBTRACT_CIPHERUINT256UINT256_ADDRESS, SUBTRACT_PLAIN_GAS, pubk, encryptedValue, plaintextValue
        );
    }

    /// Subtract a plaintext and encrypted value
    /// @dev This costs 200 gas
    /// @param pubk Bincode encoded `Sunscreen::PublicKey`
    /// @param plaintextValue Plaintext value to subtract.
    /// @param encryptedValue Bincode encoded `Sunscreen::Cipher<bfv::Unsigned256>`.
    /// @return result The encrypted subtraction `plaintextValue - encryptedValue`.
    function subtractUint256PlainEnc(bytes memory pubk, uint256 plaintextValue, bytes memory encryptedValue)
        public
        view
        returns (bytes memory)
    {
        return callUint256PlainEnc(
            SUBTRACT_UINT256CIPHERUINT256_ADDRESS, SUBTRACT_PLAIN_GAS, pubk, plaintextValue, encryptedValue
        );
    }

    /// Multiply two encrypted values
    /// @dev This costs 1000 gas
    /// @param pubk Bincode encoded `Sunscreen::PublicKey`
    /// @param a Bincode encoded `Sunscreen::Cipher<bfv::Unsigned256>`.
    /// @param b Bincode encoded `Sunscreen::Cipher<bfv::Unsigned256>`.
    /// @return result The encrypted multiplication `a * b`.
    function multiplyUint256EncEnc(bytes memory pubk, bytes memory a, bytes memory b)
        public
        view
        returns (bytes memory)
    {
        return callEnc(MULTIPLY_CIPHERUINT256CIPHERUINT256_ADDRESS, MULTIPLY_GAS, pubk, a, b);
    }

    /// Multiply an encrypted and plaintext value
    /// @dev This costs 200 gas
    /// @param pubk Bincode encoded `Sunscreen::PublicKey`
    /// @param encryptedValue Bincode encoded `Sunscreen::Cipher<bfv::Unsigned256>`.
    /// @param plaintextValue Plaintext value to multiply to a ciphertext
    /// @return result The encrypted multiplication `encryptedValue * plaintextValue`.
    function multiplyUint256EncPlain(bytes memory pubk, bytes memory encryptedValue, uint256 plaintextValue)
        public
        view
        returns (bytes memory)
    {
        return callUint256EncPlain(
            MULTIPLY_CIPHERUINT256UINT256_ADDRESS, MULTIPLY_PLAIN_GAS, pubk, encryptedValue, plaintextValue
        );
    }

    /// Multiply a plaintext and encrypted value
    /// @dev This costs 200 gas
    /// @param pubk Bincode encoded `Sunscreen::PublicKey`
    /// @param plaintextValue Plaintext value to multiply to a ciphertext
    /// @param encryptedValue Bincode encoded `Sunscreen::Cipher<bfv::Unsigned256>`.
    /// @return result The encrypted multiplication `plaintextValue * encryptedValue`.
    function multiplyUint256PlainEnc(bytes memory pubk, uint256 plaintextValue, bytes memory encryptedValue)
        public
        view
        returns (bytes memory)
    {
        return callUint256PlainEnc(
            MULTIPLY_UINT256CIPHERUINT256_ADDRESS, MULTIPLY_PLAIN_GAS, pubk, plaintextValue, encryptedValue
        );
    }

    /// Encrypt a plaintext uint256 value
    /// @dev This costs 1000 gas
    /// @param plaintextValue Plaintext value to multiply to a ciphertext
    /// @return result The encrypted `plaintextValue`
    function encryptUint256(uint256 plaintextValue) public view returns (bytes memory) {
        bytes memory msg_sender = uint256(uint160(msg.sender)).toBytes(32);
        bytes memory block_number = block.number.toBytes(32);

        bytes memory publicData = bytes.concat(msg_sender, block_number);

        bytes memory input = packUint256Bytes(plaintextValue, publicData);
        return callPrecompile(ENCRYPT_UINT256_ADDRESS, ENCRYPT_GAS, input);
    }

    /// Reencrypt a ciphertext from the network key to another key.
    /// @dev This costs 2000 gas
    /// @param pubk Bincode encoded `Sunscreen::PublicKey`
    /// @param encryptedValue Bincode encoded `Sunscreen::Cipher<bfv::Unsigned256>`.
    /// @return result The reencrypted `encryptedValue` under the provided key.
    function reencryptUint256(bytes memory pubk, bytes memory encryptedValue) public view returns (bytes memory) {
        bytes memory msg_sender = uint256(uint160(msg.sender)).toBytes(32);
        bytes memory block_number = block.number.toBytes(32);

        bytes memory publicData = bytes.concat(msg_sender, block_number);

        return callEnc(REENCRYPT_UINT256_ADDRESS, REENCRYPT_GAS, pubk, encryptedValue, publicData);
    }

    /// Refresh a ciphertext (reset the noise)
    /// @param encryptedValue Bincode encoded `Sunscreen::Cipher<bfv::Unsigned256>`.
    /// @return result The refreshed `encryptedValue`.
    function refreshUint256(bytes memory encryptedValue) public view returns (bytes memory) {
        bytes memory pubk = networkPublicKey();
        return reencryptUint256(pubk, encryptedValue);
    }

    /// Decrypts an encrypted uint256 value.
    ///
    /// @param encryptedValue The encrypted value to be decrypted.
    /// @return result The decrypted uint256 value.
    function decryptUint256(bytes memory encryptedValue) public view returns (uint256 result) {
        bytes memory output = callPrecompile(DECRYPT_UINT256_ADDRESS, DECRYPT_GAS, encryptedValue);
        result = output.fromBytesUint256();
    }

    /**
     *
     * uint64 operations
     *
     */

    /// Add two encrypted values
    /// @dev This costs 200 gas
    /// @param pubk Bincode encoded `Sunscreen::PublicKey`
    /// @param a Bincode encoded `Sunscreen::Cipher<bfv::Unsigned64>`.
    /// @param b Bincode encoded `Sunscreen::Cipher<bfv::Unsigned64>`.
    /// @return result The encrypted sum `a + b`.
    function addUint64EncEnc(bytes memory pubk, bytes memory a, bytes memory b) public view returns (bytes memory) {
        return callEnc(ADD_CIPHERUINT64CIPHERUINT64_ADDRESS, ADD_GAS, pubk, a, b);
    }

    /// Add an encrypted and plaintext value
    /// @dev This costs 200 gas
    /// @param pubk Bincode encoded `Sunscreen::PublicKey`
    /// @param encryptedValue Bincode encoded `Sunscreen::Cipher<bfv::Unsigned64>`.
    /// @param plaintextValue Plaintext value to add to a ciphertext
    /// @return result The encrypted sum `encryptedValue + plaintextValue`.
    function addUint64EncPlain(bytes memory pubk, bytes memory encryptedValue, uint64 plaintextValue)
        public
        view
        returns (bytes memory)
    {
        return callUint64EncPlain(ADD_CIPHERUINT64UINT64_ADDRESS, ADD_PLAIN_GAS, pubk, encryptedValue, plaintextValue);
    }

    /// Add a plaintext and encrypted value
    /// @dev This costs 200 gas
    /// @param pubk Bincode encoded `Sunscreen::PublicKey`
    /// @param plaintextValue Plaintext value to add to a ciphertext
    /// @param encryptedValue Bincode encoded `Sunscreen::Cipher<bfv::Unsigned64>`.
    /// @return result The encrypted sum `plaintextValue  + encryptedValue`.
    function addUint64PlainEnc(bytes memory pubk, uint64 plaintextValue, bytes memory encryptedValue)
        public
        view
        returns (bytes memory)
    {
        return callUint64PlainEnc(ADD_UINT64CIPHERUINT64_ADDRESS, ADD_PLAIN_GAS, pubk, plaintextValue, encryptedValue);
    }

    /// Subtract two encrypted values
    /// @dev This costs 200 gas
    /// @param pubk Bincode encoded `Sunscreen::PublicKey`
    /// @param a Bincode encoded `Sunscreen::Cipher<bfv::Unsigned64>`.
    /// @param b Bincode encoded `Sunscreen::Cipher<bfv::Unsigned64>`.
    /// @return result The encrypted subtraction `a - b`.
    function subtractUint64EncEnc(bytes memory pubk, bytes memory a, bytes memory b)
        public
        view
        returns (bytes memory)
    {
        return callEnc(SUBTRACT_CIPHERUINT64CIPHERUINT64_ADDRESS, SUBTRACT_GAS, pubk, a, b);
    }

    /// Subtract an encrypted and plaintext value
    /// @dev This costs 200 gas
    /// @param pubk Bincode encoded `Sunscreen::PublicKey`
    /// @param encryptedValue Bincode encoded `Sunscreen::Cipher<bfv::Unsigned64>`.
    /// @param plaintextValue Plaintext value to subtract from a ciphertext
    /// @return result The encrypted subtraction `encryptedValue - plaintextValue`.
    function subtractUint64EncPlain(bytes memory pubk, bytes memory encryptedValue, uint64 plaintextValue)
        public
        view
        returns (bytes memory)
    {
        return callUint64EncPlain(
            SUBTRACT_CIPHERUINT64UINT64_ADDRESS, SUBTRACT_PLAIN_GAS, pubk, encryptedValue, plaintextValue
        );
    }

    /// Subtract a plaintext and encrypted value
    /// @dev This costs 200 gas
    /// @param pubk Bincode encoded `Sunscreen::PublicKey`
    /// @param plaintextValue Plaintext value to subtract.
    /// @param encryptedValue Bincode encoded `Sunscreen::Cipher<bfv::Unsigned64>`.
    /// @return result The encrypted subtraction `plaintextValue - encryptedValue`.
    function subtractUint64PlainEnc(bytes memory pubk, uint64 plaintextValue, bytes memory encryptedValue)
        public
        view
        returns (bytes memory)
    {
        return callUint64PlainEnc(
            SUBTRACT_UINT64CIPHERUINT64_ADDRESS, SUBTRACT_PLAIN_GAS, pubk, plaintextValue, encryptedValue
        );
    }

    /// Multiply two encrypted values
    /// @dev This costs 1000 gas
    /// @param pubk Bincode encoded `Sunscreen::PublicKey`
    /// @param a Bincode encoded `Sunscreen::Cipher<bfv::Unsigned64>`.
    /// @param b Bincode encoded `Sunscreen::Cipher<bfv::Unsigned64>`.
    /// @return result The encrypted multiplication `a * b`.
    function multiplyUint64EncEnc(bytes memory pubk, bytes memory a, bytes memory b)
        public
        view
        returns (bytes memory)
    {
        return callEnc(MULTIPLY_CIPHERUINT64CIPHERUINT64_ADDRESS, MULTIPLY_GAS, pubk, a, b);
    }

    /// Multiply an encrypted and plaintext value
    /// @dev This costs 200 gas
    /// @param pubk Bincode encoded `Sunscreen::PublicKey`
    /// @param encryptedValue Bincode encoded `Sunscreen::Cipher<bfv::Unsigned64>`.
    /// @param plaintextValue Plaintext value to multiply to a ciphertext
    /// @return result The encrypted multiplication `encryptedValue * plaintextValue`.
    function multiplyUint64EncPlain(bytes memory pubk, bytes memory encryptedValue, uint64 plaintextValue)
        public
        view
        returns (bytes memory)
    {
        return callUint64EncPlain(
            MULTIPLY_CIPHERUINT64UINT64_ADDRESS, MULTIPLY_PLAIN_GAS, pubk, encryptedValue, plaintextValue
        );
    }

    /// Multiply a plaintext and encrypted value
    /// @dev This costs 200 gas
    /// @param pubk Bincode encoded `Sunscreen::PublicKey`
    /// @param plaintextValue Plaintext value to multiply to a ciphertext
    /// @param encryptedValue Bincode encoded `Sunscreen::Cipher<bfv::Unsigned64>`.
    /// @return result The encrypted multiplication `plaintextValue * encryptedValue`.
    function multiplyUint64PlainEnc(bytes memory pubk, uint64 plaintextValue, bytes memory encryptedValue)
        public
        view
        returns (bytes memory)
    {
        return callUint64PlainEnc(
            MULTIPLY_UINT64CIPHERUINT64_ADDRESS, MULTIPLY_PLAIN_GAS, pubk, plaintextValue, encryptedValue
        );
    }

    /// Encrypt a plaintext uint64 value
    /// @dev This costs 1000 gas
    /// @param plaintextValue Plaintext value to multiply to a ciphertext
    /// @return result The encrypted `plaintextValue`
    function encryptUint64(uint64 plaintextValue) public view returns (bytes memory) {
        bytes memory msg_sender = uint256(uint160(msg.sender)).toBytes(32);
        bytes memory block_number = block.number.toBytes(32);

        bytes memory publicData = bytes.concat(msg_sender, block_number);

        bytes memory input = packUint64Bytes(plaintextValue, publicData);
        return callPrecompile(ENCRYPT_UINT64_ADDRESS, ENCRYPT_GAS, input);
    }

    /// Reencrypt a ciphertext from the network key to another key.
    /// @dev This costs 2000 gas
    /// @param pubk Bincode encoded `Sunscreen::PublicKey`
    /// @param encryptedValue Bincode encoded `Sunscreen::Cipher<bfv::Unsigned256>`.
    /// @return result The reencrypted `encryptedValue` under the provided key.
    function reencryptUint64(bytes memory pubk, bytes memory encryptedValue) public view returns (bytes memory) {
        bytes memory msg_sender = uint256(uint160(msg.sender)).toBytes(32);
        bytes memory block_number = block.number.toBytes(32);

        bytes memory publicData = bytes.concat(msg_sender, block_number);

        return callEnc(REENCRYPT_UINT64_ADDRESS, REENCRYPT_GAS, pubk, encryptedValue, publicData);
    }

    /// Refresh a ciphertext (reset the noise)
    /// @param encryptedValue Bincode encoded `Sunscreen::Cipher<bfv::Unsigned256>`.
    /// @return result The refreshed `encryptedValue`.
    function refreshUint64(bytes memory encryptedValue) public view returns (bytes memory) {
        bytes memory pubk = networkPublicKey();
        return reencryptUint64(pubk, encryptedValue);
    }

    /// Decrypts an encrypted uint64 value.
    ///
    /// @param encryptedValue The encrypted value to be decrypted.
    /// @return result The decrypted uint64 value.
    function decryptUint64(bytes memory encryptedValue) public view returns (uint64) {
        bytes memory output = callPrecompile(DECRYPT_UINT64_ADDRESS, DECRYPT_GAS, encryptedValue);
        return output.fromBytesUint64();
    }

    /**
     *
     * int64 operations
     *
     */

    /// Add two encrypted values
    /// @dev This costs 200 gas
    /// @param pubk Bincode encoded `Sunscreen::PublicKey`
    /// @param a Bincode encoded `Sunscreen::Cipher<bfv::Signed>`.
    /// @param b Bincode encoded `Sunscreen::Cipher<bfv::Signed>`.
    /// @return result The encrypted sum `a + b`.
    function addInt64EncEnc(bytes memory pubk, bytes memory a, bytes memory b) public view returns (bytes memory) {
        return callEnc(ADD_CIPHERINT64CIPHERINT64_ADDRESS, ADD_GAS, pubk, a, b);
    }

    /// Add an encrypted and plaintext value
    /// @dev This costs 200 gas
    /// @param pubk Bincode encoded `Sunscreen::PublicKey`
    /// @param encryptedValue Bincode encoded `Sunscreen::Cipher<bfv::Signed>`.
    /// @param plaintextValue Plaintext value to add to a ciphertext
    /// @return result The encrypted sum `encryptedValue + plaintextValue`.
    function addInt64EncPlain(bytes memory pubk, bytes memory encryptedValue, int64 plaintextValue)
        public
        view
        returns (bytes memory)
    {
        return callInt64EncPlain(ADD_CIPHERINT64INT64_ADDRESS, ADD_PLAIN_GAS, pubk, encryptedValue, plaintextValue);
    }

    /// Add a plaintext and encrypted value
    /// @dev This costs 200 gas
    /// @param pubk Bincode encoded `Sunscreen::PublicKey`
    /// @param plaintextValue Plaintext value to add to a ciphertext
    /// @param encryptedValue Bincode encoded `Sunscreen::Cipher<bfv::Signed>`.
    /// @return result The encrypted sum `plaintextValue  + encryptedValue`.
    function addInt64PlainEnc(bytes memory pubk, int64 plaintextValue, bytes memory encryptedValue)
        public
        view
        returns (bytes memory)
    {
        return callInt64PlainEnc(ADD_INT64CIPHERINT64_ADDRESS, ADD_PLAIN_GAS, pubk, plaintextValue, encryptedValue);
    }

    /// Subtract two encrypted values
    /// @dev This costs 200 gas
    /// @param pubk Bincode encoded `Sunscreen::PublicKey`
    /// @param a Bincode encoded `Sunscreen::Cipher<bfv::Signed>`.
    /// @param b Bincode encoded `Sunscreen::Cipher<bfv::Signed>`.
    /// @return result The encrypted subtraction `a - b`.
    function subtractInt64EncEnc(bytes memory pubk, bytes memory a, bytes memory b)
        public
        view
        returns (bytes memory)
    {
        return callEnc(SUBTRACT_CIPHERINT64CIPHERINT64_ADDRESS, SUBTRACT_GAS, pubk, a, b);
    }

    /// Subtract an encrypted and plaintext value
    /// @dev This costs 200 gas
    /// @param pubk Bincode encoded `Sunscreen::PublicKey`
    /// @param encryptedValue Bincode encoded `Sunscreen::Cipher<bfv::Signed>`.
    /// @param plaintextValue Plaintext value to subtract from a ciphertext
    /// @return result The encrypted subtraction `encryptedValue - plaintextValue`.
    function subtractInt64EncPlain(bytes memory pubk, bytes memory encryptedValue, int64 plaintextValue)
        public
        view
        returns (bytes memory)
    {
        return callInt64EncPlain(
            SUBTRACT_CIPHERINT64INT64_ADDRESS, SUBTRACT_PLAIN_GAS, pubk, encryptedValue, plaintextValue
        );
    }

    /// Subtract a plaintext and encrypted value
    /// @dev This costs 200 gas
    /// @param pubk Bincode encoded `Sunscreen::PublicKey`
    /// @param plaintextValue Plaintext value to subtract.
    /// @param encryptedValue Bincode encoded `Sunscreen::Cipher<bfv::Signed>`.
    /// @return result The encrypted subtraction `plaintextValue - encryptedValue`.
    function subtractInt64PlainEnc(bytes memory pubk, int64 plaintextValue, bytes memory encryptedValue)
        public
        view
        returns (bytes memory)
    {
        return callInt64PlainEnc(
            SUBTRACT_INT64CIPHERINT64_ADDRESS, SUBTRACT_PLAIN_GAS, pubk, plaintextValue, encryptedValue
        );
    }

    /// Multiply two encrypted values
    /// @dev This costs 1000 gas
    /// @param pubk Bincode encoded `Sunscreen::PublicKey`
    /// @param a Bincode encoded `Sunscreen::Cipher<bfv::Signed>`.
    /// @param b Bincode encoded `Sunscreen::Cipher<bfv::Signed>`.
    /// @return result The encrypted multiplication `a * b`.
    function multiplyInt64EncEnc(bytes memory pubk, bytes memory a, bytes memory b)
        public
        view
        returns (bytes memory)
    {
        return callEnc(MULTIPLY_CIPHERINT64CIPHERINT64_ADDRESS, MULTIPLY_GAS, pubk, a, b);
    }

    /// Multiply an encrypted and plaintext value
    /// @dev This costs 200 gas
    /// @param pubk Bincode encoded `Sunscreen::PublicKey`
    /// @param encryptedValue Bincode encoded `Sunscreen::Cipher<bfv::Signed>`.
    /// @param plaintextValue Plaintext value to multiply to a ciphertext
    /// @return result The encrypted multiplication `encryptedValue * plaintextValue`.
    function multiplyInt64EncPlain(bytes memory pubk, bytes memory encryptedValue, int64 plaintextValue)
        public
        view
        returns (bytes memory)
    {
        return callInt64EncPlain(
            MULTIPLY_CIPHERINT64INT64_ADDRESS, MULTIPLY_PLAIN_GAS, pubk, encryptedValue, plaintextValue
        );
    }

    /// Multiply a plaintext and encrypted value
    /// @dev This costs 200 gas
    /// @param pubk Bincode encoded `Sunscreen::PublicKey`
    /// @param plaintextValue Plaintext value to multiply to a ciphertext
    /// @param encryptedValue Bincode encoded `Sunscreen::Cipher<bfv::Signed>`.
    /// @return result The encrypted multiplication `plaintextValue * encryptedValue`.
    function multiplyInt64PlainEnc(bytes memory pubk, int64 plaintextValue, bytes memory encryptedValue)
        public
        view
        returns (bytes memory)
    {
        return callInt64PlainEnc(
            MULTIPLY_INT64CIPHERINT64_ADDRESS, MULTIPLY_PLAIN_GAS, pubk, plaintextValue, encryptedValue
        );
    }

    /// Encrypt a plaintext int64 value
    /// @dev This costs 1000 gas
    /// @param plaintextValue Plaintext value to multiply to a ciphertext
    /// @return result The encrypted `plaintextValue`
    function encryptInt64(int64 plaintextValue) public view returns (bytes memory) {
        bytes memory msg_sender = uint256(uint160(msg.sender)).toBytes(32);
        bytes memory block_number = block.number.toBytes(32);

        bytes memory publicData = bytes.concat(msg_sender, block_number);

        bytes memory input = packInt64Bytes(plaintextValue, publicData);
        return callPrecompile(ENCRYPT_INT64_ADDRESS, ENCRYPT_GAS, input);
    }

    /// Reencrypt a ciphertext from the network key to another key.
    /// @dev This costs 2000 gas
    /// @param pubk Bincode encoded `Sunscreen::PublicKey`
    /// @param encryptedValue Bincode encoded `Sunscreen::Cipher<bfv::Unsigned256>`.
    /// @return result The reencrypted `encryptedValue` under the provided key.
    function reencryptInt64(bytes memory pubk, bytes memory encryptedValue) public view returns (bytes memory) {
        bytes memory msg_sender = uint256(uint160(msg.sender)).toBytes(32);
        bytes memory block_number = block.number.toBytes(32);

        bytes memory publicData = bytes.concat(msg_sender, block_number);

        return callEnc(REENCRYPT_INT64_ADDRESS, REENCRYPT_GAS, pubk, encryptedValue, publicData);
    }

    /// Refresh a ciphertext (reset the noise)
    /// @param encryptedValue Bincode encoded `Sunscreen::Cipher<bfv::Unsigned256>`.
    /// @return result The refreshed `encryptedValue`.
    function refreshInt64(bytes memory encryptedValue) public view returns (bytes memory) {
        bytes memory pubk = networkPublicKey();
        return reencryptInt64(pubk, encryptedValue);
    }

    /// Decrypts an encrypted int64 value.
    ///
    /// @param encryptedValue The encrypted value to be decrypted.
    /// @return result The decrypted int64 value.
    function decryptInt64(bytes memory encryptedValue) public view returns (int64) {
        bytes memory output = callPrecompile(DECRYPT_INT64_ADDRESS, DECRYPT_GAS, encryptedValue);
        return output.fromBytesInt64();
    }

    /**
     *
     * frac64 operations
     *
     */

    /// Add two encrypted values
    /// @dev This costs 200 gas
    /// @param pubk Bincode encoded `Sunscreen::PublicKey`
    /// @param a Bincode encoded `Sunscreen::Cipher<bfv::Fractional<64>>`.
    /// @param b Bincode encoded `Sunscreen::Cipher<bfv::Fractional<64>>`.
    /// @return result The encrypted sum `a + b`.
    function addFrac64EncEnc(bytes memory pubk, bytes memory a, bytes memory b) public view returns (bytes memory) {
        return callEnc(ADD_CIPHERFRAC64CIPHERFRAC64_ADDRESS, ADD_GAS, pubk, a, b);
    }

    /// Add an encrypted and plaintext value
    /// @dev This costs 200 gas
    /// @param pubk Bincode encoded `Sunscreen::PublicKey`
    /// @param encryptedValue Bincode encoded `Sunscreen::Cipher<bfv::Fractional<64>>`.
    /// @param plaintextValue Big-Endian encoded double.
    /// @return result The encrypted sum `encryptedValue + plaintextValue`.
    function addFrac64EncPlain(bytes memory pubk, bytes memory encryptedValue, bytes8 plaintextValue)
        public
        view
        returns (bytes memory)
    {
        return callFrac64EncPlain(ADD_CIPHERFRAC64FRAC64_ADDRESS, ADD_PLAIN_GAS, pubk, encryptedValue, plaintextValue);
    }

    /// Add a plaintext and encrypted value
    /// @dev This costs 200 gas
    /// @param pubk Bincode encoded `Sunscreen::PublicKey`
    /// @param plaintextValue Big-Endian encoded double.
    /// @param encryptedValue Bincode encoded `Sunscreen::Cipher<bfv::Fractional<64>>`.
    /// @return result The encrypted sum `plaintextValue  + encryptedValue`.
    function addFrac64PlainEnc(bytes memory pubk, bytes8 plaintextValue, bytes memory encryptedValue)
        public
        view
        returns (bytes memory)
    {
        return callFrac64PlainEnc(ADD_FRAC64CIPHERFRAC64_ADDRESS, ADD_PLAIN_GAS, pubk, plaintextValue, encryptedValue);
    }

    /// Subtract two encrypted values
    /// @dev This costs 200 gas
    /// @param pubk Bincode encoded `Sunscreen::PublicKey`
    /// @param a Bincode encoded `Sunscreen::Cipher<bfv::Fractional<64>>`.
    /// @param b Bincode encoded `Sunscreen::Cipher<bfv::Fractional<64>>`.
    /// @return result The encrypted subtraction `a - b`.
    function subtractFrac64EncEnc(bytes memory pubk, bytes memory a, bytes memory b)
        public
        view
        returns (bytes memory)
    {
        return callEnc(SUBTRACT_CIPHERFRAC64CIPHERFRAC64_ADDRESS, SUBTRACT_GAS, pubk, a, b);
    }

    /// Subtract an encrypted and plaintext value
    /// @dev This costs 200 gas
    /// @param pubk Bincode encoded `Sunscreen::PublicKey`
    /// @param encryptedValue Bincode encoded `Sunscreen::Cipher<bfv::Fractional<64>>`.
    /// @param plaintextValue Big-Endian encoded double.
    /// @return result The encrypted subtraction `encryptedValue - plaintextValue`.
    function subtractFrac64EncPlain(bytes memory pubk, bytes memory encryptedValue, bytes8 plaintextValue)
        public
        view
        returns (bytes memory)
    {
        return callFrac64EncPlain(
            SUBTRACT_CIPHERFRAC64FRAC64_ADDRESS, SUBTRACT_PLAIN_GAS, pubk, encryptedValue, plaintextValue
        );
    }

    /// Subtract a plaintext and encrypted value
    /// @dev This costs 200 gas
    /// @param pubk Bincode encoded `Sunscreen::PublicKey`
    /// @param plaintextValue Big-Endian encoded double.
    /// @param encryptedValue Bincode encoded `Sunscreen::Cipher<bfv::Fractional<64>>`.
    /// @return result The encrypted subtraction `plaintextValue - encryptedValue`.
    function subtractFrac64PlainEnc(bytes memory pubk, bytes8 plaintextValue, bytes memory encryptedValue)
        public
        view
        returns (bytes memory)
    {
        return callFrac64PlainEnc(
            SUBTRACT_FRAC64CIPHERFRAC64_ADDRESS, SUBTRACT_PLAIN_GAS, pubk, plaintextValue, encryptedValue
        );
    }

    /// Multiply two encrypted values
    /// @dev This costs 1000 gas
    /// @param pubk Bincode encoded `Sunscreen::PublicKey`
    /// @param a Bincode encoded `Sunscreen::Cipher<bfv::Fractional<64>>`.
    /// @param b Bincode encoded `Sunscreen::Cipher<bfv::Fractional<64>>`.
    /// @return result The encrypted multiplication `a * b`.
    function multiplyFrac64EncEnc(bytes memory pubk, bytes memory a, bytes memory b)
        public
        view
        returns (bytes memory)
    {
        return callEnc(MULTIPLY_CIPHERFRAC64CIPHERFRAC64_ADDRESS, MULTIPLY_GAS, pubk, a, b);
    }

    /// Multiply an encrypted and plaintext value
    /// @dev This costs 200 gas
    /// @param pubk Bincode encoded `Sunscreen::PublicKey`
    /// @param encryptedValue Bincode encoded `Sunscreen::Cipher<bfv::Fractional<64>>`.
    /// @param plaintextValue Big-Endian encoded double.
    /// @return result The encrypted multiplication `encryptedValue * plaintextValue`.
    function multiplyFrac64EncPlain(bytes memory pubk, bytes memory encryptedValue, bytes8 plaintextValue)
        public
        view
        returns (bytes memory)
    {
        return callFrac64EncPlain(
            MULTIPLY_CIPHERFRAC64FRAC64_ADDRESS, MULTIPLY_PLAIN_GAS, pubk, encryptedValue, plaintextValue
        );
    }

    /// Multiply a plaintext and encrypted value
    /// @dev This costs 200 gas
    /// @param pubk Bincode encoded `Sunscreen::PublicKey`
    /// @param plaintextValue Big-Endian encoded double.
    /// @param encryptedValue Bincode encoded `Sunscreen::Cipher<bfv::Fractional<64>>`.
    /// @return result The encrypted multiplication `plaintextValue * encryptedValue`.
    function multiplyFrac64PlainEnc(bytes memory pubk, bytes8 plaintextValue, bytes memory encryptedValue)
        public
        view
        returns (bytes memory)
    {
        return callFrac64PlainEnc(
            MULTIPLY_FRAC64CIPHERFRAC64_ADDRESS, MULTIPLY_PLAIN_GAS, pubk, plaintextValue, encryptedValue
        );
    }

    /// Encrypt a plaintext Fractional<64> value
    /// @dev This costs 1000 gas
    /// @param plaintextValue Plaintext value to multiply to a ciphertext
    /// @return result The encrypted `plaintextValue`
    function encryptFrac64(bytes8 plaintextValue) public view returns (bytes memory) {
        bytes memory msg_sender = uint256(uint160(msg.sender)).toBytes(32);
        bytes memory block_number = block.number.toBytes(32);

        bytes memory publicData = bytes.concat(msg_sender, block_number);

        bytes memory input = packFrac64Bytes(plaintextValue, publicData);
        return callPrecompile(ENCRYPT_FRAC64_ADDRESS, ENCRYPT_GAS, input);
    }

    /// Reencrypt a ciphertext from the network key to another key.
    /// @dev This costs 2000 gas
    /// @param pubk Bincode encoded `Sunscreen::PublicKey`
    /// @param encryptedValue Bincode encoded `Sunscreen::Cipher<bfv::Unsigned256>`.
    /// @return result The reencrypted `encryptedValue` under the provided key.
    function reencryptFrac64(bytes memory pubk, bytes memory encryptedValue) public view returns (bytes memory) {
        bytes memory msg_sender = uint256(uint160(msg.sender)).toBytes(32);
        bytes memory block_number = block.number.toBytes(32);

        bytes memory publicData = bytes.concat(msg_sender, block_number);

        return callEnc(REENCRYPT_FRAC64_ADDRESS, REENCRYPT_GAS, pubk, encryptedValue, publicData);
    }

    /// Refresh a ciphertext (reset the noise)
    /// @param encryptedValue Bincode encoded `Sunscreen::Cipher<bfv::Unsigned256>`.
    /// @return result The refreshed `encryptedValue`.
    function refreshFrac64(bytes memory encryptedValue) public view returns (bytes memory) {
        bytes memory pubk = networkPublicKey();
        return reencryptFrac64(pubk, encryptedValue);
    }

    /// Decrypts an encrypted frac64 value.
    ///
    /// @param encryptedValue The encrypted value to be decrypted.
    /// @return result The decrypted frac64 value.
    function decryptFrac64(bytes memory encryptedValue) public view returns (bytes8) {
        bytes memory output = callPrecompile(DECRYPT_FRAC64_ADDRESS, DECRYPT_GAS, encryptedValue);
        return output.fromBytesFrac64();
    }

    /// Returns the public key of the network.
    /// @return bytes The public key of the network.
    function networkPublicKey() public view returns (bytes memory) {
        return callPrecompile(FHE_NETWORK_PUBLIC_KEY_ADDRESS, NETWORK_PUBLIC_KEY_GAS, "");
    }
}
