function addLockups(address[] calldata _lockups) external onlyOwner {
        require(lockups.length == 0);
        uint256 lockupsLength = _lockups.length;
        for (uint256 i = 0; i < lockupsLength; i++) {
            require(ITokenLockup(_lockups[i]).token() == address(this));
            lockups.push(_lockups[i]);
        }
    }