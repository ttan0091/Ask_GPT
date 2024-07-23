function allowance(address _owner, address _spender)
    public
    view
    returns (uint256 _value)
  {
    if (_spender == mainchainGateway) return uint256(-1);

    return _allowance[_owner][_spender];
  }