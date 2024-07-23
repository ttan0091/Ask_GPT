function addSupportedChainId(uint256 chainId) public {
        require(bridgeRoles.has(msg.sender), "Unauthorized.");

        // Check that the chain ID is not the chain this contract is deployed on.
        uint256 currentChainId;
        assembly {
            currentChainId := chainid()
        }
        require(chainId != currentChainId, "Cannot add current chain ID.");

        // Already supported, no-op.
        if (chainIds[chainId] == true) {
            return;
        }

        chainIds[chainId] = true;
        emit AddSupportedChainId(chainId);
    }