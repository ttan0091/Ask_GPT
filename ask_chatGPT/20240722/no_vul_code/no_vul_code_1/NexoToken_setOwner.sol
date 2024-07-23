function setOwner(address _new)
		public
		onlyOwner
	{
		emit NewPotentialOwner(owner, _new);
		potentialOwner = _new;
	}