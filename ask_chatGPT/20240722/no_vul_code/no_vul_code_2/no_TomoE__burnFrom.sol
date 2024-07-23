function _burnFrom(address account, uint256 value) internal {
	  require(value <= _allowed[account][msg.sender]);

	  // Should https://github.com/OpenZeppelin/zeppelin-solidity/issues/707 be accepted,
	  // this function needs to emit an event with the updated approval.
	  _allowed[account][msg.sender] = _allowed[account][msg.sender].sub(
		  value);
		  _burn(account, value);
  }