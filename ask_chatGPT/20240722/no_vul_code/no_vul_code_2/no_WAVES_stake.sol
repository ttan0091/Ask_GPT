function stake(uint256 reward) external onlyOwner onlyNotDeprecated override virtual returns (bool) {
    require(reward > 0, "reward should be > 0");

    uint256 liquidTotalSupply = _liquidTotalSupply;
    uint256 liquidDeposit = _liquidDeposit;

    if (liquidTotalSupply == 0) {
      _percents.push(PERCENT_FACTOR);
    } else {
      uint256 oldPercent = _percents[_percents.length - 1];
      uint256 percent = reward * PERCENT_FACTOR / liquidTotalSupply;
      require(percent + PERCENT_FACTOR >= percent, "addition overflow for percent");
      uint256 newPercent = percent + PERCENT_FACTOR;
      _percents.push(newPercent * oldPercent / PERCENT_FACTOR);

      require(liquidTotalSupply + reward >= liquidTotalSupply, "addition overflow for total supply + reward");
      liquidTotalSupply = liquidTotalSupply + reward;
    }

    require(liquidTotalSupply + liquidDeposit >= liquidTotalSupply, "addition overflow for total supply");
    _liquidTotalSupply = liquidTotalSupply + liquidDeposit;
    _liquidDeposit = 0;

    emit Reward(_percents.length, reward);
    return true;
  }