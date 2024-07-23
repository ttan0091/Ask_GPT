function freeze(address _addr, uint256 _value) public {
        require(owner == msg.sender);                //Check owner
        require(balanceOf[_addr] >= _value);         // Check if the sender has enough
		require(_value > 0);                         //Check _value is valid
        balanceOf[_addr] = SafeMath.sub(balanceOf[_addr], _value);              // Subtract _value amount from balance of _addr address
        freezeOf[_addr] = SafeMath.add(freezeOf[_addr], _value);                // Add the same amount to freeze of _addr address
        emit Freeze(_addr, _value);
    }