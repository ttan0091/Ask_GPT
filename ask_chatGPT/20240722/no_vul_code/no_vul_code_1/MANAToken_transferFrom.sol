function transferFrom(address _from, address _to, uint _value) whenNotPaused returns (bool) {
    return super.transferFrom(_from, _to, _value);
  }