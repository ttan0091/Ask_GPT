function transfer(address _to, uint256 _value) public {
        require(_to != 0x0);                                // Prevent transfer to 0x0 address.
        require(_value > 0);                                // Check send amount is greater than 0.
        require(balanceOf[msg.sender] >= _value);           // Check balance of the sender is enough
        require(balanceOf[_to] + _value > balanceOf[_to]);  // Check for overflow
        balanceOf[msg.sender] = SafeMath.sub(balanceOf[msg.sender], _value);// Subtract _value amount from the sender
        balanceOf[_to] = SafeMath.add(balanceOf[_to], _value);// Add the same amount to the recipient
        emit Transfer(msg.sender, _to, _value);// Notify anyone listening that this transfer took place
    }