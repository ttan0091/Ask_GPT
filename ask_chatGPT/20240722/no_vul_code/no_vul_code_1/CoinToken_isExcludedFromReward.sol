function isExcludedFromReward(address account) public view returns (bool) {
        return _isExcluded[account];
    }