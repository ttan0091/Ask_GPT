function totalSupply() external view override virtual returns (uint256) {
    uint256 liquidTotalSupply = _liquidTotalSupply;
    uint256 liquidDeposit = _liquidDeposit;

    require(liquidTotalSupply + liquidDeposit >= liquidTotalSupply, "addition overflow for total supply");
    return liquidTotalSupply + liquidDeposit;
  }