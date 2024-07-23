function setTotalSupply(uint256 amount) external onlyCaller {
        totalSupply = amount;
    }