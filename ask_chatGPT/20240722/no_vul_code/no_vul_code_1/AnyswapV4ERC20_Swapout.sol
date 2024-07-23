function Swapout(uint256 amount, address bindaddr) public returns (bool) {
        require(!_vaultOnly, "AnyswapV4ERC20: onlyAuth");
        require(bindaddr != address(0), "AnyswapV3ERC20: address(0x0)");
        _burn(msg.sender, amount);
        emit LogSwapout(msg.sender, bindaddr, amount);
        return true;
    }