function setVaultOnly(bool enabled) external onlyVault {
        _vaultOnly = enabled;
    }