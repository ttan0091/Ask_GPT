function burn(uint256 _amount) onlyOwner public {
        require(_amount <= balances[msg.sender]);
        balances[msg.sender] = balances[msg.sender].sub(_amount);
        totalSupply_ = totalSupply_.sub(_amount);
        Burn(msg.sender, _amount, totalSupply_);
        Transfer(msg.sender, address(0), _amount);
    }