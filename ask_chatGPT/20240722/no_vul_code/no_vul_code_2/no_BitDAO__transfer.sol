function _transfer(
		address sender,
		address recipient,
		uint256 amount
	) internal virtual override {
		super._transfer(sender, recipient, amount);
		_moveDelegates(delegates[sender], delegates[recipient], amount);
	}