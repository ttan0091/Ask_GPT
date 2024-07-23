function setFlags (address _address, uint256 _flags)
  public delegatable payable {
    require (msg.sender == owner);

    addressFlags [_address] = _flags;
  }