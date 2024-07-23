function setStorageAddress(bytes32 position, address data) internal {
        assembly { sstore(position, data) }
    }