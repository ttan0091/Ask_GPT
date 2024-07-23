function freezeTransfers () public delegatable payable {
    require (msg.sender == owner);

    if (!frozen) {
      frozen = true;

      Freeze ();
    }
  }