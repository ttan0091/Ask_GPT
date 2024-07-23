function releaseAdvisorTokens() advisorTimelock ownerOnly returns(bool success) {
        require(totalAllocatedToAdvisors == 0);
        balanceOf[advisorAddress] = safeAdd(balanceOf[advisorAddress], advisorsAllocation);
        totalAllocated = safeAdd(totalAllocated, advisorsAllocation);
        totalAllocatedToAdvisors = advisorsAllocation;
        Transfer(0x0, advisorAddress, advisorsAllocation);
        return true;
    }