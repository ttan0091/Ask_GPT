function decreaseAllowance(address _spender, uint256 _value) public returns (bool) {
    _approve(msg.sender, _spender, _allowance[msg.sender][_spender].sub(_value));
    return true;
  }