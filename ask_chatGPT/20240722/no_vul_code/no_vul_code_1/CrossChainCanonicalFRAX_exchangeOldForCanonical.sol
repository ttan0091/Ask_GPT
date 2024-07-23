function exchangeOldForCanonical(address bridge_token_address, uint256 token_amount) external nonReentrant validBridgeToken(bridge_token_address) returns (uint256 canonical_tokens_out) {
        require(!exchangesPaused && canSwap[bridge_token_address], "Exchanges paused");

        // Pull in the old tokens
        TransferHelper.safeTransferFrom(bridge_token_address, msg.sender, address(this), token_amount);

        // Handle the fee, if applicable
        canonical_tokens_out = token_amount;
        if (!_isFeeExempt(msg.sender)) {
            canonical_tokens_out -= ((canonical_tokens_out * swap_fees[bridge_token_address][0]) / PRICE_PRECISION);
        }

        // Mint canonical tokens and give it to the sender
        _mint_capped(msg.sender, canonical_tokens_out);
    }