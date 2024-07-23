function isAvailableLockSlot(address _account, uint _term) public view returns (bool) {
        if (!mayHaveLockedTokens[_account]) return true;
        if (_term < now) return true;
        uint[LOCK_SLOTS] storage term = lockTerm[_account];
        for (uint i; i < LOCK_SLOTS; i++) {
            if (term[i] < now || term[i] == _term) return true;
        }
        return false;
    }