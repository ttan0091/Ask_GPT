function transfer (address _to, uint256 _value)
  public delegatable payable returns (bool) {
    if (frozen) return false;
    else if (
      (addressFlags [msg.sender] | addressFlags [_to]) & BLACK_LIST_FLAG ==
      BLACK_LIST_FLAG)
      return false;
    else {
      uint256 fee =
        (addressFlags [msg.sender] | addressFlags [_to]) & ZERO_FEE_FLAG == ZERO_FEE_FLAG ?
          0 :
          calculateFee (_value);

      if (_value <= accounts [msg.sender] &&
          fee <= safeSub (accounts [msg.sender], _value)) {
        require (AbstractToken.transfer (_to, _value));
        require (AbstractToken.transfer (feeCollector, fee));
        return true;
      } else return false;
    }
  }