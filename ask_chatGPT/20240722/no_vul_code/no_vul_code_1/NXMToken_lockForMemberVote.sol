function lockForMemberVote(address _of, uint _days) public onlyOperator {
        if (_days.add(now) > isLockedForMV[_of])
            isLockedForMV[_of] = _days.add(now);
    }