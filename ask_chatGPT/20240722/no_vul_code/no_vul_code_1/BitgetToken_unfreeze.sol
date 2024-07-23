function unfreeze(address _addr, uint256 _value) public {
        require(owner == msg.sender);                //Check owner
        require(freezeOf[_addr] >= _value);          // Check if the sender has enough
		require(_value > 0);                         //Check _value is valid
        freezeOf[_addr] = SafeMath.sub(freezeOf[_addr], _value);                // Subtract _value amount from freeze of _addr address
		balanceOf[_addr] = SafeMath.add(balanceOf[_addr], _value);              // Add the same amount to balance of _addr address
        emit Unfreeze(_addr, _value);
    }