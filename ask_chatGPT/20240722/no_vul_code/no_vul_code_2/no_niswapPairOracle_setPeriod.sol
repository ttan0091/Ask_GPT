function setPeriod(uint _period) external onlyByOwnerOrGovernance {
        PERIOD = _period;
    }