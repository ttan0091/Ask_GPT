function setSwapFees(address bridge_token_address, uint256 _bridge_to_canonical, uint256 _canonical_to_old) external onlyByOwnGov {
        swap_fees[bridge_token_address] = [_bridge_to_canonical, _canonical_to_old];
    }