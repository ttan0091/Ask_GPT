function mint(address to, uint256 amount) external checkRole(MINTER_ROLE, msg.sender, 'Caller is not a minter') {
    super._mint(to, amount);
  }