function mintAlgorithmicFRAX(uint256 fxs_amount_d18, uint256 FRAX_out_min) external notMintPaused {
        uint256 fxs_price = FRAX.fxs_price();
        uint256 global_collateral_ratio = FRAX.global_collateral_ratio();
        require(global_collateral_ratio == 0, "Collateral ratio must be 0");
        
        (uint256 frax_amount_d18) = FraxPoolLibrary.calcMintAlgorithmicFRAX(
            minting_fee, 
            fxs_price, // X FXS / 1 USD
            fxs_amount_d18
        );

        require(FRAX_out_min <= frax_amount_d18, "Slippage limit reached");
        FXS.pool_burn_from(msg.sender, fxs_amount_d18);
        FRAX.pool_mint(msg.sender, frax_amount_d18);
    }