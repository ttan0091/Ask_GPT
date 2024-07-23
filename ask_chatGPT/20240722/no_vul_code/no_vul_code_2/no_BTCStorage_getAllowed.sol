function getAllowed(address owner,address spender) external view returns(uint256) {
        return allowed[owner][spender];
    }