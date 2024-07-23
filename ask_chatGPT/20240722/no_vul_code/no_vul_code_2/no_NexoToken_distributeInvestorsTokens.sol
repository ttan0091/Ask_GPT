function distributeInvestorsTokens(address _to, uint256 _amountWithDecimals)
		public
		onlyOwner
	{
		require(transferFrom(investorsAllocation, _to, _amountWithDecimals));
	}