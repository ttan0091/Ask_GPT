function buyBackFXS(uint256 FXS_amount, uint256 COLLATERAL_out_min) external {
        require(buyBackPaused == false, "Buyback is paused");
        uint256 fxs_price = FRAX.fxs_price();
        
        FraxPoolLibrary.BuybackFXS_Params memory input_params = FraxPoolLibrary.BuybackFXS_Params(
            availableExcessCollatDV(),
            fxs_price,
            getCollateralPrice(),
            FXS_amount
        );

        (uint256 collateral_equivalent_d18) = FraxPoolLibrary.calcBuyBackFXS(input_params);
        uint256 collateral_precision = collateral_equivalent_d18.div(10 ** missing_decimals);

        require(COLLATERAL_out_min <= collateral_precision, "Slippage limit reached");
        // Give the sender their desired collateral and burn the FXS
        FXS.pool_burn_from(msg.sender, FXS_amount);
        collateral_token.transfer(msg.sender, collateral_precision);
    }