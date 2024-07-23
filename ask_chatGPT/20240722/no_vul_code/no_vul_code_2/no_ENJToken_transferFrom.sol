function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        if (isTransferAllowed() == true || msg.sender == crowdFundAddress || msg.sender == incentivisationFundAddress) {        
            assert(super.transferFrom(_from, _to, _value));
            return true;
        }
        revert();
    }