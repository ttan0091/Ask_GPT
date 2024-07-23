function calculateFee (uint256 _amount)
    public delegatable view returns (uint256 _fee) {
    require (_amount <= MAX_TOKENS_COUNT);

    _fee = safeMul (_amount, variableFeeNumerator) / FEE_DENOMINATOR;
    if (_fee < minVariableFee) _fee = minVariableFee;
    if (_fee > maxVariableFee) _fee = maxVariableFee;
    _fee = safeAdd (_fee, fixedFee);
  }