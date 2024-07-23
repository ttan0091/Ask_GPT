function getVotes(address account) public view returns (uint96) {
        uint256 pos = _checkpoints[account].length;
        return pos == 0 ? 0 : decodeValue(_checkpoints[account][pos - 1]);
    }