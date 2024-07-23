function burn(uint256 amount) public validLock permissionCheck returns (bool) {
        _burn(_msgSender(), amount);
        return true;
    }