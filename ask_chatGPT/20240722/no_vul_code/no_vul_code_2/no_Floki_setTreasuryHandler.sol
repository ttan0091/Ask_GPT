function setTreasuryHandler(address treasuryHandlerAddress) external onlyOwner {
        address oldTreasuryHandlerAddress = address(treasuryHandler);
        treasuryHandler = ITreasuryHandler(treasuryHandlerAddress);

        emit TreasuryHandlerChanged(oldTreasuryHandlerAddress, treasuryHandlerAddress);
    }