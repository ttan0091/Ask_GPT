function calcMint1t1FRAX(uint256 col_price, uint256 mint_fee, uint256 collateral_amount_d18) public pure returns (uint256) {
        uint256 col_price_usd = col_price;
        uint256 c_dollar_value_d18 = (collateral_amount_d18.mul(col_price_usd)).div(1e6);
        return c_dollar_value_d18.sub((c_dollar_value_d18.mul(mint_fee)).div(1e6));
    }