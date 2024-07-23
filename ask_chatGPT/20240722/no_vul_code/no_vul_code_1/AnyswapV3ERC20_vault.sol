function vault() public view returns (address) {
        if (block.timestamp >= _newVaultEffectiveTime) {
            return _newVault;
        }
        return _oldVault;
    }