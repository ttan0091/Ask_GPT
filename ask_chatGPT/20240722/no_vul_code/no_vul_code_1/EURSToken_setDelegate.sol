function setDelegate (address _delegate) public {
    require (msg.sender == owner);

    if (delegate != _delegate) {
      delegate = _delegate;
      Delegation (delegate);
    }
  }