function withdrawBridgeTokens(address bridge_token_address, uint256 bridge_token_amount) external onlyMintersOwnGov validBridgeToken(bridge_token_address) {
        TransferHelper.safeTransfer(bridge_token_address, msg.sender, bridge_token_amount);
    }