function evaluateBy(address operator, uint256 target, uint256 desired) public view returns(uint256) {
    // read operator's permissions
    uint256 p = userRoles[operator];

    // taking into account operator's permissions,
    // 1) enable the permissions desired on the `target`
    target |= p & desired;
    // 2) disable the permissions desired on the `target`
    target &= FULL_PRIVILEGES_MASK ^ (p & (FULL_PRIVILEGES_MASK ^ desired));

    // return calculated result
    return target;
  }