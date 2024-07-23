function _valueAt(uint256 snapshotId, Snapshots storage snapshots) private view returns (bool, uint256) {
		require(snapshotId > 0, 'ERC20Snapshot: id is 0');
		require(snapshotId <= _currentSnapshotId.current(), 'ERC20Snapshot: nonexistent id');

		uint256 index = snapshots.ids.findUpperBound(snapshotId);

		if (index == snapshots.ids.length) {
			return (false, 0);
		} else {
			return (true, snapshots.values[index]);
		}
	}