function balanceOf(address tokenOwner) public view returns (uint256 balance) {
        return balances[tokenOwner];
    }