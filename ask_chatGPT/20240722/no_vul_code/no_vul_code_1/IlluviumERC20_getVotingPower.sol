function getVotingPower(address _of) public view returns (uint256) {
    // get a link to an array of voting power history records for an address specified
    VotingPowerRecord[] storage history = votingPowerHistory[_of];

    // lookup the history and return latest element
    return history.length == 0? 0: history[history.length - 1].votingPower;
  }