function transfer(address _to, uint256 _value) public returns (bool) {
        require(_to != address(0), "Address must not be zero.");
        require(_value <= balances[msg.sender], "There is no enough balance.");

        balances[msg.sender] = balances[msg.sender].sub(_value);
        balances[_to] = balances[_to].add(_value);
        emit Transfer(msg.sender, _to, _value);
        return true;
    }