function balanceOf(address tokenOwner) public view returns (uint balance) {

        return balances[tokenOwner];

    }