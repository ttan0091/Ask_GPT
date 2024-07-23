function reclaimToken(ERC20Basic _token) external onlyOwner {
    uint256 balance = _token.balanceOf(address(this));
    _token.safeTransfer(owner, balance);
  }