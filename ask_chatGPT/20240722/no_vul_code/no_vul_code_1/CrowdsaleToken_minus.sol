function minus(uint a, uint b) returns (uint) {
    assert(b <= a);
    return a - b;
  }