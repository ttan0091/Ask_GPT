function calcRedeem1t1FRAX(uint256 col_price_usd, uint256 FRAX_amount, uint256 redemption_fee) public pure returns (uint256) {
        uint256 collateral_needed_d18 = FRAX_amount.mul(1e6).div(col_price_usd);
        return collateral_needed_d18.sub((collateral_needed_d18.mul(redemption_fee)).div(1e6));
    }