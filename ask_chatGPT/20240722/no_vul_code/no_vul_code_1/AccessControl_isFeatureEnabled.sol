function isFeatureEnabled(uint256 required) public view returns(bool) {
    // delegate call to `__hasRole`, passing `features` property
    return __hasRole(features(), required);
  }