function getPriorVotes(address account, uint256 blockNumber) public view returns (uint256) {
		require(blockNumber < block.number, 'BitDAO::getPriorVotes: not yet determined');

		uint256 nCheckpoints = numCheckpoints[account];
		if (nCheckpoints == 0) {
			return 0;
		}

		if (checkpoints[account][nCheckpoints - 1].fromBlock <= blockNumber) {
			return checkpoints[account][nCheckpoints - 1].votes;
		}

		if (checkpoints[account][0].fromBlock > blockNumber) {
			return 0;
		}

		uint256 lower = 0;
		uint256 upper = nCheckpoints - 1;
		while (upper > lower) {
			uint256 center = upper - (upper - lower) / 2;
			Checkpoint memory cp = checkpoints[account][center];
			if (cp.fromBlock == blockNumber) {
				return cp.votes;
			} else if (cp.fromBlock < blockNumber) {
				lower = center;
			} else {
				upper = center - 1;
			}
		}
		return checkpoints[account][lower].votes;
	}