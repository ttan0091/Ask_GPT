function transfer(address to, uint256 value) public onlyActive returns (bool success) {
        if (to == address(0)) {
            revert();
        }
    	if (value <= 0) {
    		revert();
        }
        if (balances[msg.sender] < value) {
            revert();
        }
        balances[msg.sender] = balances[msg.sender].sub(value);
        balances[to] = balances[to].add(value);
        emit Transfer(msg.sender, to, value);
        return true;
    }