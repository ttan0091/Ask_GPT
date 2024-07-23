function redeem1t1FRAX(uint256 FRAX_amount, uint256 COLLATERAL_out_min) external notRedeemPaused {
        uint256 global_collateral_ratio = FRAX.global_collateral_ratio();
        require(global_collateral_ratio == COLLATERAL_RATIO_MAX, "Collateral ratio must be == 1");

        // Need to adjust for decimals of collateral
        uint256 FRAX_amount_precision = FRAX_amount.div(10 ** missing_decimals);
        (uint256 collateral_needed) = FraxPoolLibrary.calcRedeem1t1FRAX(
            getCollateralPrice(),
            FRAX_amount_precision,
            redemption_fee
        );

        require(collateral_needed <= collateral_token.balanceOf(address(this)).sub(unclaimedPoolCollateral), "Not enough collateral in pool");

        redeemCollateralBalances[msg.sender] = redeemCollateralBalances[msg.sender].add(collateral_needed);
        unclaimedPoolCollateral = unclaimedPoolCollateral.add(collateral_needed);
        lastRedeemed[msg.sender] = block.number;

        require(COLLATERAL_out_min <= collateral_needed, "Slippage limit reached");
        
        // Move all external functions to the end
        FRAX.pool_burn_from(msg.sender, FRAX_amount);
    }