function _payOFTFee(address _from, uint16 _dstChainId, uint _amount) internal virtual returns (uint amount, uint fee) {
        fee = quoteOFTFee(_dstChainId, _amount);
        amount = _amount - fee;
        if (fee > 0) {
            _transferFrom(_from, feeOwner, fee);
        }
    }