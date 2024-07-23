function burn(uint256 amount) external override {
        _burn(msg.sender, amount);
    }