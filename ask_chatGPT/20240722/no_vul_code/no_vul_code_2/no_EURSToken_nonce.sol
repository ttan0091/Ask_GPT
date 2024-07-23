function nonce (address _owner) public view delegatable returns (uint256) {
    return nonces [_owner];
  }