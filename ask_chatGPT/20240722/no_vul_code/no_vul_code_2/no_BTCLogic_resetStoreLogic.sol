function resetStoreLogic(address storeAddress) external onlyCaller {
        store = HBTCStorage(storeAddress);
    }