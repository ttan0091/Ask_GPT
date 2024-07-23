function getVotingPowerHistory(address _of) public view returns(VotingPowerRecord[] memory) {
    // return an entire array as memory
    return votingPowerHistory[_of];
  }