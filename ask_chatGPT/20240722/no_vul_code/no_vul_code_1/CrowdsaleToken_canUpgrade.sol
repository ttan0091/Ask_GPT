function canUpgrade() public constant returns(bool) {
    return released && super.canUpgrade();
  }