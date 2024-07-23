function calcMintAlgorithmicFRAX(uint256 mint_fee, uint256 fxs_price_usd, uint256 fxs_amount_d18) public pure returns (uint256) {
        uint256 fxs_dollar_value_d18 = fxs_amount_d18.mul(fxs_price_usd).div(1e6);
        return fxs_dollar_value_d18.sub((fxs_dollar_value_d18.mul(mint_fee)).div(1e6));
    }