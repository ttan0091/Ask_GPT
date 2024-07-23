function EURSToken (address _feeCollector) public {
    fixedFee = DEFAULT_FEE;
    minVariableFee = 0;
    maxVariableFee = 0;
    variableFeeNumerator = 0;

    owner = msg.sender;
    feeCollector = _feeCollector;
  }