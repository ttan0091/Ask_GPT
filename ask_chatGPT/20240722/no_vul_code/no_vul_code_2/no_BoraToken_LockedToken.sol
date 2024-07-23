function LockedToken(ERC20Basic _token, address _donor, address _beneficiary, uint256 _releaseTime, bool _revocable) public {
        require(_token != address(0));
        require(_donor != address(0));
        require(_beneficiary != address(0));
        require(_releaseTime > now);

        token = ERC20Basic(_token);
        donor = _donor;
        beneficiary = _beneficiary;
        releaseTime = _releaseTime;
        revocable = _revocable;
    }