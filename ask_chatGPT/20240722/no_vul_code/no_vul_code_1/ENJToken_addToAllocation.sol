function addToAllocation(uint256 _amount) crowdfundOnly {
        totalAllocated = safeAdd(totalAllocated, _amount);
    }