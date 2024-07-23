function revoke() public {
        require(msg.sender == _timelock_address, "Must be called by the timelock contract");
        require(_revocable, "TokenVesting: cannot revoke");
        require(!_revoked, "TokenVesting: token already revoked");

        uint256 balance = FXS.balanceOf(address(this));

        uint256 unreleased = _releasableAmount();
        uint256 refund = balance.sub(unreleased);

        _revoked = true;

        FXS.transfer(_owner, refund);

        emit TokenVestingRevoked();
    }