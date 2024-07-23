function setAllowed(address owner,address spender,uint256 amount) external onlyCaller {
        require(owner != address(0),"owner address error");
        require(spender != address(0),"spender address error");
        require(amount <= balances[owner], "owner balance need >= amount");
        allowed[owner][spender] = amount;
    }