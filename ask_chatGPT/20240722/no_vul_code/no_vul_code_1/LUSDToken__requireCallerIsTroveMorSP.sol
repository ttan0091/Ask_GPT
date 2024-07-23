function _requireCallerIsTroveMorSP() internal view {
        require(
            msg.sender == troveManagerAddress || msg.sender == stabilityPoolAddress,
            "LUSD: Caller is neither TroveManager nor StabilityPool");
    }