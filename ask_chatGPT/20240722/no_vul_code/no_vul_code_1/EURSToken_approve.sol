function approve (address _spender, uint256 _value)
  public delegatable payable returns (bool success) {
    return AbstractToken.approve (_spender, _value);
  }