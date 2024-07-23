function burn(uint256 value) external {
        _burn(msg.sender, value);
    }