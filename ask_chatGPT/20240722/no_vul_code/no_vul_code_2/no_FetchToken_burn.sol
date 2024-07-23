function burn(uint256 amount) external {
        _burn(_msgSender(), amount);
    }