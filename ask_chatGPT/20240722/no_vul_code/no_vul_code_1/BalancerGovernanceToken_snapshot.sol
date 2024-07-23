function snapshot() public virtual {
        require(hasRole(SNAPSHOT_ROLE, _msgSender()), "ERR_SNAPSHOT_ROLE");
        _snapshot();
    }