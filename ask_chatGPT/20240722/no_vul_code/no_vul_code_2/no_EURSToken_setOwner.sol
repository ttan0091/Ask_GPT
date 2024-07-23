function setOwner (address _newOwner) public {
    require (msg.sender == owner);

    owner = _newOwner;
  }