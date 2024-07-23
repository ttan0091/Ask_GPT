function setOwnerAndTimelock(address _new_owner, address _new_timelock) external onlyByOwnerOrGovernance {
        owner_address = _new_owner;
        timelock_address = _new_timelock;
    }