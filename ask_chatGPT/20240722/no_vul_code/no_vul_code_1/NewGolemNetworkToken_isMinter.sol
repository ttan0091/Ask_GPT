function isMinter(address account) public view returns (bool) {
        return _minters.has(account);
    }