function _beforeTokenTransfer(
		address from,
		address to,
		uint256 amount
	) internal virtual override {
		super._beforeTokenTransfer(from, to, amount);
		if (from == address(0)) {
			// mint
			_updateAccountSnapshot(to);
			_updateTotalSupplySnapshot();
		} else if (to == address(0)) {
			// burn
			_updateAccountSnapshot(from);
			_updateTotalSupplySnapshot();
		} else {
			// transfer
			_updateAccountSnapshot(from);
			_updateAccountSnapshot(to);
		}
	}