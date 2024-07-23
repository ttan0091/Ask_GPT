function balanceOf(address _owner) constant returns (uint) {
        return balances[_owner];
    }