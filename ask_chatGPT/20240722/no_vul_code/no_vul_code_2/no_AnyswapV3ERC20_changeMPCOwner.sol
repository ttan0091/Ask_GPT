function changeMPCOwner(address newVault) public onlyVault returns (bool) {
        require(newVault != address(0), "AnyswapV3ERC20: address(0x0)");
        _oldVault = vault();
        _newVault = newVault;
        _newVaultEffectiveTime = block.timestamp + 2*24*3600;
        emit LogChangeMPCOwner(_oldVault, _newVault, _newVaultEffectiveTime);
        return true;
    }