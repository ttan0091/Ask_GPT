function burn(uint256 amount) public returns (bool) {
    _burn(_msgSender(), amount);
    return true;
  }