function _requireCallerIsStabilityPool() internal view {
        require(msg.sender == stabilityPoolAddress, "LUSD: Caller is not the StabilityPool");
    }