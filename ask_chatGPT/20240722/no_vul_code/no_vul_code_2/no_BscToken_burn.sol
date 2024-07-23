function burn(uint256 value) external {
        require(balances[msg.sender] >= value, "WOOBscToken: NOT_ENOUGH");
        balances[msg.sender] = balances[msg.sender].sub(value);
        totalSupply = totalSupply.sub(value);
        emit Burn(msg.sender, value);
        emit Transfer(msg.sender, address(0), value);
    }