function finishMinting() external onlyMinter returns (bool) {
    mintingFinished = true;
    MintingFinished();
    return true;
  }