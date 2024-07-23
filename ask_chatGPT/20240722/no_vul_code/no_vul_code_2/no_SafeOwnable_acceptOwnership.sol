function acceptOwnership () virtual public onlyNomineeOwner {
    OwnableStorage.Layout storage l = OwnableStorage.layout();
    emit OwnershipTransferred(l.owner, msg.sender);
    l.setOwner(msg.sender);
    SafeOwnableStorage.layout().setNomineeOwner(address(0));
  }