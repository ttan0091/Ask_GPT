function isPauser(address account) public view returns (bool) {
    return pausers.has(account);
  }