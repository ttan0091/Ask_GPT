function _removePauser(address account) internal {
    pausers.remove(account);
    emit PauserRemoved(account);
  }