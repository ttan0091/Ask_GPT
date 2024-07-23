function increaseApproval(address _spender, uint256 _value) public returns (bool success) {
		allowed[msg.sender][_spender] = add(allowed[msg.sender][_spender], _value);
		emit Approval(msg.sender, _spender, allowed[msg.sender][_spender]);
		return true;
	}