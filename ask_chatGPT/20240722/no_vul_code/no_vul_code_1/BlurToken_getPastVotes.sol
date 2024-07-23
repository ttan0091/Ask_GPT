function getPastVotes(address account, uint256 blockNumber) public view override returns (uint256) {
        return ERC20Votes.getPastVotes(account, blockNumber) + _getTokenLockupBalance(account);
    }