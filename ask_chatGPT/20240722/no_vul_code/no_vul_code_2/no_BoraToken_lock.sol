function lock(address _donor, address _beneficiary, uint256 amount, uint256 _duration, bool _revocable) onlyOwner public returns (LockedToken) {
        uint256 releaseTime = now.add(_duration.mul(1 days));
        LockedToken lockedToken = new LockedToken(this, _donor, _beneficiary, releaseTime, _revocable);
        BasicToken.transfer(lockedToken, amount);
        Lock(lockedToken, _beneficiary, lockedToken.balanceOf(), releaseTime);
        return lockedToken;
    }