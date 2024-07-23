function transferFrom(
    address _from,
    address _to,
    uint256 _value
  )
    public
    returns (bool _success)
  {
    if (allowance(_from, msg.sender) != uint256(-1)) {
      super._approve(_from, msg.sender, _allowance[_from][msg.sender].sub(_value));
    }

    _transfer(_from, _to, _value);
    return true;
  }