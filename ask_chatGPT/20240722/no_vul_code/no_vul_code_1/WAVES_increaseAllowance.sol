function increaseAllowance(address spender, uint256 addedValue) external override virtual returns (bool) {
    uint256 temp = _allowances[msg.sender][spender];
    require(temp + addedValue >= temp, "addition overflow");
    _approve(msg.sender, spender, temp + addedValue);
    return true;
  }