function getVotingPowerAt(address _of, uint256 _blockNum) public view returns (uint256) {
    // make sure block number is not in the past (not the finalized block)
    require(_blockNum < block.number, "not yet determined"); // Compound msg

    // get a link to an array of voting power history records for an address specified
    VotingPowerRecord[] storage history = votingPowerHistory[_of];

    // if voting power history for the account provided is empty
    if(history.length == 0) {
      // than voting power is zero - return the result
      return 0;
    }

    // check latest voting power history record block number:
    // if history was not updated after the block of interest
    if(history[history.length - 1].blockNumber <= _blockNum) {
      // we're done - return last voting power record
      return getVotingPower(_of);
    }

    // check first voting power history record block number:
    // if history was never updated before the block of interest
    if(history[0].blockNumber > _blockNum) {
      // we're done - voting power at the block num of interest was zero
      return 0;
    }

    // `votingPowerHistory[_of]` is an array ordered by `blockNumber`, ascending;
    // apply binary search on `votingPowerHistory[_of]` to find such an entry number `i`, that
    // `votingPowerHistory[_of][i].blockNumber <= _blockNum`, but in the same time
    // `votingPowerHistory[_of][i + 1].blockNumber > _blockNum`
    // return the result - voting power found at index `i`
    return history[__binaryLookup(_of, _blockNum)].votingPower;
  }