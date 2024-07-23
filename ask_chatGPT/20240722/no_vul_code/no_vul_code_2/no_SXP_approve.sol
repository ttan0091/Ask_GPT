function approve(address spender, uint256 amount) external validLock permissionCheck returns (bool) {
        _approve(_msgSender(), spender, amount);
        return true;
    }