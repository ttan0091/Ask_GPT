function allowance (address _owner, address _spender)
  public delegatable view returns (uint256 remaining) {
    return AbstractToken.allowance (_owner, _spender);
  }