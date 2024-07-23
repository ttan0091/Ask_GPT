function burn(uint256 amount) public returns (bool) {
        _burn(msg.sender, amount);
        return true;
    }