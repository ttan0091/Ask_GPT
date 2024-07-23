function removeAllFee() private { 
        _previousTaxFee = _taxFee;
        _previousDevFee = _devFee;
        _previousLiquidityFee = _liquidityFee;
        
        _taxFee = 0;
        _devFee = 0;
        _liquidityFee = 0;
    }