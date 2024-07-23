function transfer(address _to, uint256 _value) public returns (bool) {
        // if _to is address(0), invoke burn function.
        if (_to == address(0)) {
            return burn(_value);
        }

        require(_value <= balances[msg.sender]);
        // SafeMath.sub will throw if there is not enough balance.
        balances[msg.sender] = balances[msg.sender].sub(_value);
        balances[_to] = balances[_to].add(_value);
        emit Transfer(msg.sender, _to, _value);
        return true;
    }