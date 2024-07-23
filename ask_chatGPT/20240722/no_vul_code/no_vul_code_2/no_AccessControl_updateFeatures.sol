function updateFeatures(uint256 _mask) public {
    // delegate call to `updateRole`
    updateRole(address(0), _mask);
  }