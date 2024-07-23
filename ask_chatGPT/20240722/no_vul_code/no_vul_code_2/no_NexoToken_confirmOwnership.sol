function confirmOwnership()
		public
		onlyPotentialOwner
	{   
		// Forbid the old owner to distribute investors' tokens
		allowed[investorsAllocation][owner] = 0;

		// Allow the new owner to distribute investors' tokens
		allowed[investorsAllocation][msg.sender] = balanceOf(investorsAllocation);

		// Forbid the old owner to withdraw any tokens from the reserves
		allowed[overdraftAllocation][owner] = 0;
		allowed[teamAllocation][owner] = 0;
		allowed[communityAllocation][owner] = 0;
		allowed[advisersAllocation][owner] = 0;

		super.confirmOwnership();
	}