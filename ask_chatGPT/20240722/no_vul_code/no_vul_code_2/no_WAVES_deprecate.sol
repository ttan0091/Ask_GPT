function deprecate() external onlyOwner {
    deprecated = true;
    emit Deprecate(msg.sender);
  }