function __hasRole(uint256 actual, uint256 required) internal pure returns(bool) {
    // check the bitmask for the role required and return the result
    return actual & required == required;
  }