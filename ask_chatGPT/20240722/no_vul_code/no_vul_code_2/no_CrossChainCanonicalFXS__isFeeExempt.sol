function _isFeeExempt(address the_address) internal view returns (bool) {
        return (_isMinterOwnGov(the_address) || fee_exempt_list[the_address]);
    }