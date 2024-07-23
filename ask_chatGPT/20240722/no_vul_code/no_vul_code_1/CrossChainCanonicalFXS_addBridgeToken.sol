function addBridgeToken(address bridge_token_address) external onlyByOwnGov {
        // Make sure the token is not already present
        for (uint i = 0; i < bridge_tokens_array.length; i++){ 
            if (bridge_tokens_array[i] == bridge_token_address){
                revert("Token already present");
            }
        }

        // Add the old token
        bridge_tokens[bridge_token_address] = true;
        bridge_tokens_array.push(bridge_token_address);

        // Turn swapping on
        canSwap[bridge_token_address] = true;

        emit BridgeTokenAdded(bridge_token_address);
    }