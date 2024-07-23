function doubleSend(address to, uint256 amount1, uint256 amount2) external {
        AAVE.transfer(to, amount1);
        AAVE.transfer(to, amount2);
    }