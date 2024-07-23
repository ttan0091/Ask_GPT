function mint(uint256 value) public returns (bool) {
        _mint(msg.sender, value);
        return true;
    }