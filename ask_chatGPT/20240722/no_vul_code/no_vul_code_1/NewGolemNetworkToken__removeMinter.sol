function _removeMinter(address account) internal {
        _minters.remove(account);
        emit MinterRemoved(account);
    }