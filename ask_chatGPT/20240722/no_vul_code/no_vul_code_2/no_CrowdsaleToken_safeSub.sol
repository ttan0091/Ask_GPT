function safeSub(uint a, uint b) internal returns (uint) {
    assert(b <= a);
    return a - b;
  }