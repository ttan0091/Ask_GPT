function fxs_price()  public view returns (uint256) {
        return oracle_price(PriceChoice.FXS);
    }