function changeMinter(address newMinter) external onlyMinter {
        _changeMinter(newMinter);
    }