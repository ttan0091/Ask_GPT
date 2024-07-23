function setStorageUint256(bytes32 position, uint256 data) internal {
        assembly { sstore(position, data) }
    }