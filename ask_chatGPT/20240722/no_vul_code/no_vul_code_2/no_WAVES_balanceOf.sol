function balanceOf(address account) public view override virtual returns (uint256) {
    uint256 balance = _balances[account];
    uint256 oldDeposit = _deposits[account];

    if (balance == 0 && oldDeposit == 0) {
      return 0;
    }

    uint256 rewardIndex = _rewardIndexForAccount[account];
    if (rewardIndex == _percents.length - 1) {
      require(balance + oldDeposit >= balance, "addition overflow for balance");
      return balance + oldDeposit;
    }

    if (oldDeposit == 0) {
      uint256 profit = _percents[_percents.length - 1];
      return profit * balance / _percents[rewardIndex];
    } else {
      uint256 newBalance = balance * _percents[_percents.length - 1] / _percents[rewardIndex];
      uint256 profit = oldDeposit * _percents[_percents.length - 1] / _percents[rewardIndex + 1];
      require(profit + newBalance >= newBalance, "addition overflow for balance");
      return profit + newBalance;
    }
  }