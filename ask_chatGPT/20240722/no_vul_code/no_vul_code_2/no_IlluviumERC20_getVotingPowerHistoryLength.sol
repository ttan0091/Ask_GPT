function getVotingPowerHistoryLength(address _of) public view returns(uint256) {
    // read array length and return
    return votingPowerHistory[_of].length;
  }