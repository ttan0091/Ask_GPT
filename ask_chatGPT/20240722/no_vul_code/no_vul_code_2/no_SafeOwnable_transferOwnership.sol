function transferOwnership (
    address account
  ) virtual override public onlyOwner {
    SafeOwnableStorage.layout().setNomineeOwner(account);
  }