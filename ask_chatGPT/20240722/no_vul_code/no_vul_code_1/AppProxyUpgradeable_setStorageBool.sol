function setStorageBool(bytes32 position, bool data) internal {
        assembly { sstore(position, data) }
    }