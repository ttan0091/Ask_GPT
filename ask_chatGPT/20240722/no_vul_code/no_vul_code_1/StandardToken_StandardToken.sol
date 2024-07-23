function StandardToken(address _crowdsale) public {
    require(_crowdsale != address(0));
    crowdsale = _crowdsale;
  }