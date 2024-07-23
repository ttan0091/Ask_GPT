function quoteOFTFee(uint16 _dstChainId, uint _amount) public virtual view returns (uint fee) {
        FeeConfig memory config = chainIdToFeeBps[_dstChainId];
        if (config.enabled) {
            fee = _amount * config.feeBP / BP_DENOMINATOR;
        } else if (defaultFeeBp > 0) {
            fee = _amount * defaultFeeBp / BP_DENOMINATOR;
        } else {
            fee = 0;
        }
    }