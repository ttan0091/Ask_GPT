function transfer(address _to, uint _value) whenNotPaused returns (bool) {
    return super.transfer(_to, _value);
  }