function isDepositable() public view returns (bool) {
        return DEPOSITABLE_POSITION.getStorageBool();
    }