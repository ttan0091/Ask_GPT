function approve(address _spender, uint256 _value) public whenMintingFinished returns (bool) {
    allowed[msg.sender][_spender] = _value;
    Approval(msg.sender, _spender, _value);
    return true;
  }