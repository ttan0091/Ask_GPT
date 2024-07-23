function getCurrentVotes(address account) external view returns (uint256) {
		uint256 nCheckpoints = numCheckpoints[account];
		return nCheckpoints > 0 ? checkpoints[account][nCheckpoints - 1].votes : 0;
	}