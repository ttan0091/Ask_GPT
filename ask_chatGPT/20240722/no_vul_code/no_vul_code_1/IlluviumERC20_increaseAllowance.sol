function increaseAllowance(address _spender, uint256 _value) public virtual returns (bool) {
    // read current allowance value
    uint256 currentVal = transferAllowances[msg.sender][_spender];

    // non-zero _value and arithmetic overflow check on the allowance
    require(currentVal + _value > currentVal, "zero value approval increase or arithmetic overflow");

    // delegate call to `approve` with the new value
    return approve(_spender, currentVal + _value);
  }