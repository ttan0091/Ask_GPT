function _addMinter(address account) internal {
        _minters.add(account);
        emit MinterAdded(account);
    }