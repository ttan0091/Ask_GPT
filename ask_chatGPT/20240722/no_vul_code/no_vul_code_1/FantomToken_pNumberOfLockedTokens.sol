function pNumberOfLockedTokens(address _account) private view returns (uint locked) {
        uint[LOCK_SLOTS] storage term = lockTerm[_account];
        uint[LOCK_SLOTS] storage amnt = lockAmnt[_account];
        for (uint i; i < LOCK_SLOTS; i++) {
            if (term[i] >= now) locked = locked.add(amnt[i]);
        }
    }