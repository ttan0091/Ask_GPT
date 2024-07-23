function setBalance(address account,uint256 amount) external onlyCaller {
        require(account != address(0),"account address error");
        balances[account] = amount;
    }