function transferOwnership(address newOwner) public onlyOwner {
    pendingOwner = newOwner;
  }