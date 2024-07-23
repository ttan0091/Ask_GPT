function toggleBridgeToken(address bridge_token_address) external onlyByOwnGov {
        bridge_tokens[bridge_token_address] = !bridge_tokens[bridge_token_address];

        // Toggle swapping
        canSwap[bridge_token_address] = !canSwap[bridge_token_address];

        emit BridgeTokenToggled(bridge_token_address, !bridge_tokens[bridge_token_address]);
    }