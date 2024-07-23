function totalSupplyAt(uint256 snapshotId) public view virtual returns (uint256) {
		(bool snapshotted, uint256 value) = _valueAt(snapshotId, _totalSupplySnapshots);

		return snapshotted ? value : totalSupply();
	}