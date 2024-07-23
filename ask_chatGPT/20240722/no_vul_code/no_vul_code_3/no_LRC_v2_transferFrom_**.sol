function transferFrom(address _from, address _to, uint256 _value) public returns (bool) {
        if (_to == address(0)) {
            return burnFrom(_from, _value);
        }

        require(_value <= balances[_from]);
        require(_value <= allowed[_from][msg.sender]);
        balances[_from] = balances[_from].sub(_value);
        balances[_to] = balances[_to].add(_value);

        /// an allowance of MAX_UINT represents an unlimited allowance.
        /// @dev see https://github.com/ethereum/EIPs/issues/717
        if (allowed[_from][msg.sender] < MAX_UINT) {
            allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(_value);
        }
        emit Transfer(_from, _to, _value);
        return true;
    }