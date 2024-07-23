function getPastTotalSupply(uint256 blockNumber)
        public
        view
        returns (uint96)
    {
        return lookupCheckpoint(_totalSupplyCheckpoints, blockNumber);
    }