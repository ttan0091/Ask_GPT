function burn(uint256 _amount) external onlyDestroyer {
    require(balances[destroyer] >= _amount && _amount > 0);
    balances[destroyer] = balances[destroyer].sub(_amount);
    totalSupply = totalSupply.sub(_amount);
    Burn(_amount);
  }