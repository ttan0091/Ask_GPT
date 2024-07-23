function setFeeCollector (address _newFeeCollector)
  public delegatable payable {
    require (msg.sender == owner);

    feeCollector = _newFeeCollector;
  }