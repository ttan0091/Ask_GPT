function withdrawCommunityTokens(address _to, uint256 _amountWithDecimals)
		public
		onlyOwner 
	{
		allowed[communityAllocation][msg.sender] = allowance(communityAllocation, msg.sender);
		require(transferFrom(communityAllocation, _to, _amountWithDecimals));
	}