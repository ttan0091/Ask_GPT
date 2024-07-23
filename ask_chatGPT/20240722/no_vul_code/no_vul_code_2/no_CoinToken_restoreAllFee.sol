function restoreAllFee() private {
        _taxFee = _previousTaxFee;
        _devFee = _previousDevFee;
        _liquidityFee = _previousLiquidityFee;
    }