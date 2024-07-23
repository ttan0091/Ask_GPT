function delegate(address delegatee) public validLock permissionCheck {
        return _delegate(_msgSender(), delegatee);
    }