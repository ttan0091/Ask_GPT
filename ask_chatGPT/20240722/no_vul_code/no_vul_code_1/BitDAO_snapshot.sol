function snapshot() external virtual onlyAdmin returns (uint256) {
		_currentSnapshotId.increment();

		uint256 currentId = _currentSnapshotId.current();
		emit Snapshot(currentId);
		return currentId;
	}