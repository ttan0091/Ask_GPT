function balanceOf (address _owner)
    public delegatable view returns (uint256 balance) {
    return AbstractToken.balanceOf (_owner);
  }