function investedAssets() external view virtual override(IStrategy) returns (uint256) {
    uint256 underlyingBalance = _getUnderlyingBalance() + pendingDeposits;
    uint256 aUstBalance = _getAUstBalance() + pendingRedeems;

    return underlyingBalance + ((exchangeRateFeeder.exchangeRateOf(address(aUstToken), true) * aUstBalance) / 1e18);
}