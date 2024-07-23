function burn(uint256 _value) public {
        require(owner == msg.sender);                //Check owner
        require(balanceOf[msg.sender] >= _value);    // Check if the sender has enough
        require(_value > 0);                         //Check _value is valid
        balanceOf[msg.sender] = SafeMath.sub(balanceOf[msg.sender], _value);    // Subtract from the owner
        totalSupply = SafeMath.sub(totalSupply,_value);                         // Updates totalSupply
        emit Burn(msg.sender, _value);
    }