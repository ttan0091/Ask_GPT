function allowance(address owner, address spender) public view returns (uint256) {
        return allowed[owner][spender];
    }