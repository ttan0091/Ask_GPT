function mint(address user, uint256 amount)
        external
        onlyRole(MINTER_ROLE)
        returns (bool)
    {
        _mint(user, amount);
        return true;
    }