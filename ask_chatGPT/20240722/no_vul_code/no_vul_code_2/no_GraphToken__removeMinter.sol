function _removeMinter(address _account) private {
        _minters[_account] = false;
        emit MinterRemoved(_account);
    }