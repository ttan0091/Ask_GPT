function _writeCheckpoint(
		address delegatee,
		uint256 nCheckpoints,
		uint256 oldVotes,
		uint256 newVotes
	) internal {
		uint256 blockNumber = safe32(block.number, 'BitDAO::_writeCheckpoint: block number exceeds 32 bits');

		if (nCheckpoints > 0 && checkpoints[delegatee][nCheckpoints - 1].fromBlock == blockNumber) {
			checkpoints[delegatee][nCheckpoints - 1].votes = newVotes;
		} else {
			checkpoints[delegatee][nCheckpoints] = Checkpoint(blockNumber, newVotes);
			numCheckpoints[delegatee] = nCheckpoints + 1;
		}

		emit DelegateVotesChanged(delegatee, oldVotes, newVotes);
	}