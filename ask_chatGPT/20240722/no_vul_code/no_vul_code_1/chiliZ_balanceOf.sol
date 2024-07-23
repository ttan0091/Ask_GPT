function balanceOf(address owner) public view returns (uint256) {
    return _balances[owner];
  }