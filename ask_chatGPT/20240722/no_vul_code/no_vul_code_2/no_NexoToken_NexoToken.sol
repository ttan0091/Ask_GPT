function NexoToken() public {
		//  Overall, 1,000,000,000 tokens exist
		totalSupply = 1000000000e18;

		balances[investorsAllocation] = investorsTotal;
		balances[overdraftAllocation] = overdraftTotal;
		balances[teamAllocation] = teamTotal;
		balances[communityAllocation] = communityTotal;
		balances[advisersAllocation] = advisersTotal;

		// Unlock some tokens without vesting
		allowed[investorsAllocation][msg.sender] = investorsTotal;
		allowed[overdraftAllocation][msg.sender] = overdraftUnvested;
		allowed[communityAllocation][msg.sender] = communityUnvested;
		allowed[advisersAllocation][msg.sender] = advisersUnvested;
	}