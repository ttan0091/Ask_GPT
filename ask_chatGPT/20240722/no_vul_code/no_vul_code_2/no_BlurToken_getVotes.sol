function getVotes(address account) public view override returns (uint256) {
        return ERC20Votes.getVotes(account) + _getTokenLockupBalance(account);
    }