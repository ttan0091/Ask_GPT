function burnFrom(address _owner, uint256 _value) public returns (bool) {
        require(_owner != address(0));
        require(_value <= balances[_owner]);
        require(_value <= allowed[_owner][msg.sender]);

        balances[_owner] = balances[_owner].sub(_value);
        if (allowed[_owner][msg.sender] < MAX_UINT) {
            allowed[_owner][msg.sender] = allowed[_owner][msg.sender].sub(_value);
        }
        totalSupply_ = totalSupply_.sub(_value);
        burnedTotalNum_ = burnedTotalNum_.add(_value);

        emit Burn(_owner, _value);
        return true;
    }