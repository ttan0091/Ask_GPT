function balanceOf(address owner) public view returns (uint256 balance) {
        return balances[owner];
    }