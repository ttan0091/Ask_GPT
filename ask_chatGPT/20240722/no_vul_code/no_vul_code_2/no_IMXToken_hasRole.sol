function hasRole(bytes32 role, address account) public view override returns (bool) {
        return _roles[role].members[account];
    }