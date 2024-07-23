function _addPauser(address account) internal {
    pausers.add(account);
    emit PauserAdded(account);
  }