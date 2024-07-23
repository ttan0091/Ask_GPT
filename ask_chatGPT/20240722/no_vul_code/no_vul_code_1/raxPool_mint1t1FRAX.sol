function mint1t1FRAX(uint256 collateral_amount, uint256 FRAX_out_min) external notMintPaused {
        uint256 collateral_amount_d18 = collateral_amount * (10 ** missing_decimals);
        uint256 global_collateral_ratio = FRAX.global_collateral_ratio();

        require(global_collateral_ratio >= COLLATERAL_RATIO_MAX, "Collateral ratio must be >= 1");
        require((collateral_token.balanceOf(address(this))).sub(unclaimedPoolCollateral).add(collateral_amount) <= pool_ceiling, "[Pool's Closed]: Ceiling reached");
        
        (uint256 frax_amount_d18) = FraxPoolLibrary.calcMint1t1FRAX(
            getCollateralPrice(),
            minting_fee,
            collateral_amount_d18
        ); //1 FRAX for each $1 worth of collateral

        require(FRAX_out_min <= frax_amount_d18, "Slippage limit reached");
        collateral_token.transferFrom(msg.sender, address(this), collateral_amount);
        FRAX.pool_mint(msg.sender, frax_amount_d18);
    }