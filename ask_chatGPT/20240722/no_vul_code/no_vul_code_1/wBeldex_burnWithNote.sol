function burnWithNote(uint256 _value, string memory _note) public {
    _burn(msg.sender, _value, _note);
  }