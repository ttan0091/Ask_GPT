function withdrawTeamTokens(address _to, uint256 _amountWithDecimals)
		public
		onlyOwner 
	{
		allowed[teamAllocation][msg.sender] = allowance(teamAllocation, msg.sender);
		require(transferFrom(teamAllocation, _to, _amountWithDecimals));
	}