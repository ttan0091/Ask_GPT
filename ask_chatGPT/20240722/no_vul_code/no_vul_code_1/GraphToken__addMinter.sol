function _addMinter(address _account) private {
        _minters[_account] = true;
        emit MinterAdded(_account);
    }