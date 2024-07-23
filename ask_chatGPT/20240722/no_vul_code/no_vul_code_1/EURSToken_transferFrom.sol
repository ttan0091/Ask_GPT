function transferFrom (address _from, address _to, uint256 _value)
  public delegatable payable returns (bool) {
    if (frozen) return false;
    else if (
      (addressFlags [_from] | addressFlags [_to]) & BLACK_LIST_FLAG ==
      BLACK_LIST_FLAG)
      return false;
    else {
      uint256 fee =
        (addressFlags [_from] | addressFlags [_to]) & ZERO_FEE_FLAG == ZERO_FEE_FLAG ?
          0 :
          calculateFee (_value);

      if (_value <= allowances [_from][msg.sender] &&
          fee <= safeSub (allowances [_from][msg.sender], _value) &&
          _value <= accounts [_from] &&
          fee <= safeSub (accounts [_from], _value)) {
        require (AbstractToken.transferFrom (_from, _to, _value));
        require (AbstractToken.transferFrom (_from, feeCollector, fee));
        return true;
      } else return false;
    }
  }