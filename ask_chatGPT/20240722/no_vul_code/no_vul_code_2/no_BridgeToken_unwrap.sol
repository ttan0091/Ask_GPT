function unwrap(uint256 amount, uint256 chainId) public {
        require(tx.origin == msg.sender, "Contract calls not supported.");
        require(chainIds[chainId] == true, "Chain ID not supported.");
        _burn(msg.sender, amount);
        emit Unwrap(amount, chainId);
    }