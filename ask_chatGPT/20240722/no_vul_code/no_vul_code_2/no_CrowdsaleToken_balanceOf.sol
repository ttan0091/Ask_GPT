function balanceOf(address _owner) constant returns (uint balance) {
    return balances[_owner];
  }