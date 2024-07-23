function nomineeOwner () virtual public view returns (address) {
    return SafeOwnableStorage.layout().nomineeOwner;
  }