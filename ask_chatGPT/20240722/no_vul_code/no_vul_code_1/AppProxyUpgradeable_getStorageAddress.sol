function getStorageAddress(bytes32 position) internal view returns (address data) {
        assembly { data := sload(position) }
    }