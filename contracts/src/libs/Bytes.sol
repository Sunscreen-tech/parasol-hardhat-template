pragma solidity ^0.8.19;

library Bytes {
    /**
     *
     * Types to bytes memory conversions
     *
     */

    /**
     * Copies 'len' bytes from 'self' into a new 'bytes memory', starting at index '0'.
     * Returns the newly created 'bytes memory'
     * The returned bytes will be of length 'len'.
     */
    function toBytes(bytes32 self, uint8 len) internal pure returns (bytes memory bts) {
        require(len <= 32);
        bts = new bytes(len);
        // Even though the bytes will allocate a full word, we don't want
        // any potential garbage bytes in there.
        uint256 data = uint256(self) & ~uint256(0) << (32 - len) * 8;
        assembly {
            mstore(add(bts, 32), data)
        }
    }

    /**
     * Copies 'self' into a new 'bytes memory'.
     *
     * Requires that:
     *  - '8 <= bitsize <= 256'
     *  - 'bitsize % 8 == 0'
     * The returned bytes will be of length 'bitsize / 8'.
     *
     * @param self The uint256 value to convert.
     * @param bitsize The number of bits to copy from 'self'.
     * @return bts The bytes representation of the uint256 value. The bytes will
     *             be of length 'bitsize / 8'.
     */
    function toBytes(uint256 self, uint16 bitsize) internal pure returns (bytes memory bts) {
        require(8 <= bitsize && bitsize <= 256 && bitsize % 8 == 0);
        self <<= 256 - bitsize;
        bts = toBytes(bytes32(self), uint8(bitsize / 8));
    }

    /**
     * Copies 'self' into a new 'bytes memory'.
     *
     * @param self The uint256 value to convert.
     * @return bts The bytes representation of the uint256 value. The bytes will
     *             be of length 32.
     */
    function toBytes(uint256 self) internal pure returns (bytes memory bts) {
        bts = toBytes(bytes32(self), 32);
    }

    /**
     * Converts an int64 value to bytes.
     * @param self The int64 value to convert.
     * @return bts The bytes representation of the int64 value. The bytes
     *             will be of length 8.
     */
    function toBytes(int64 self) internal pure returns (bytes memory bts) {
        int64 data = self << (256 - 64);

        bts = new bytes(8);
        assembly {
            mstore(add(bts, 32), data)
        }
    }

    /**
     * Converts a bytes8 to its 8 bytes memory representation.
     * @param self The bytes8 value to convert.
     * @return bts The bytes representation of the bytes8 value. The bytes
     *             will be of length 8.
     */
    function toBytes(bytes8 self) internal pure returns (bytes memory bts) {
        bts = new bytes(8);
        assembly {
            mstore(add(bts, 32), self)
        }
    }

    /**
     *
     * Bytes memory to types conversions
     *
     */

    /**
     * Converts a bytes array to a uint256 value.
     *
     * @param self The bytes array to convert. Must be 32 bytes long.
     * @return result The uint256 value represented by the bytes array.
     */
    function fromBytesUint256(bytes memory self) internal pure returns (uint256) {
        require(self.length == 32);

        return uint256(bytes32(self));
    }

    /**
     * Converts a byte array to an unsigned 64-bit integer.
     *
     * @param self The input byte array. Must be 8 bytes long.
     * @return result The converted unsigned 64-bit integer.
     */
    function fromBytesUint64(bytes memory self) internal pure returns (uint64) {
        require(self.length == 8);

        return uint64(bytes8(self));
    }

    /**
     * Converts a byte array to a signed 64-bit integer.
     *
     * @param self The input byte array. Must be 8 bytes long.
     * @return result The converted signed 64-bit integer.
     */
    function fromBytesInt64(bytes memory self) internal pure returns (int64) {
        // Not sure why this works but it is implied by this post:
        // https://ethereum.stackexchange.com/a/112263
        //
        // Attempting to perform an mload like in the Frac64 case causes the
        // interpreted value to be zero.
        require(self.length == 8);
        return int64(uint64(bytes8(self)));
    }

    /**
     * Converts a byte array to a 64 bit floating point value, big endian encoded.
     *
     * @param self The input byte array. Must be 8 bytes long.
     * @return result The converted floating 64-bit value.
     */
    function fromBytesFrac64(bytes memory self) internal pure returns (bytes8) {
        require(self.length == 8);
        bytes8 out;
        assembly {
            out := mload(add(self, 32))
        }
        return out;
    }
}
