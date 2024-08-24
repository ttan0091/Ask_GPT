function changeVault(address newVault) external onlyVault returns (bool) {
        require(newVault != address(0), "AnyswapV3ERC20: address(0x0)");
        pendingVault = newVault;
        delayVault = block.timestamp + delay;
        emit LogChangeVault(vault, pendingVault, delayVault);
        return true;
    }