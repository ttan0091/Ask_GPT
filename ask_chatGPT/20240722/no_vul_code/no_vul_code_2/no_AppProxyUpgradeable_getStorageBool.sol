function getStorageBool(bytes32 position) internal view returns (bool data) {
        assembly { data := sload(position) }
    }