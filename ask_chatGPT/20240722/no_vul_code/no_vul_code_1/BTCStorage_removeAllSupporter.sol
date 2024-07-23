function removeAllSupporter(bytes32 taskHash) external onlyCaller{
        removeItemAddresses(taskHash);
    }