function burn(uint256 _value) public returns (bool) {
        require(_value <= balances[msg.sender]);

        address burner = msg.sender;
        balances[burner] = balances[burner].sub(_value);
        totalSupply_ = totalSupply_.sub(_value);
        burnedTotalNum_ = burnedTotalNum_.add(_value);

        emit Burn(burner, _value);
        return true;
    }