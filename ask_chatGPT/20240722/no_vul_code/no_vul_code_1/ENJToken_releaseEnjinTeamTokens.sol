function releaseEnjinTeamTokens() safeTimelock ownerOnly returns(bool success) {
        require(totalAllocatedToTeam < enjinTeamAllocation);

        uint256 enjinTeamAlloc = enjinTeamAllocation / 1000;
        uint256 currentTranche = uint256(now - endTime) / 12 weeks;     // "months" after crowdsale end time (division floored)

        if(teamTranchesReleased < maxTeamTranches && currentTranche > teamTranchesReleased) {
            teamTranchesReleased++;

            uint256 amount = safeMul(enjinTeamAlloc, 125);
            balanceOf[enjinTeamAddress] = safeAdd(balanceOf[enjinTeamAddress], amount);
            Transfer(0x0, enjinTeamAddress, amount);
            totalAllocated = safeAdd(totalAllocated, amount);
            totalAllocatedToTeam = safeAdd(totalAllocatedToTeam, amount);
            return true;
        }
        revert();
    }