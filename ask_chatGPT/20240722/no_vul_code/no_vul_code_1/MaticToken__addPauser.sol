function _addPauser(address account) internal {
        _pausers.add(account);
        emit PauserAdded(account);
    }