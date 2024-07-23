function flags (address _address) public delegatable view returns (uint256) {
    return addressFlags [_address];
  }