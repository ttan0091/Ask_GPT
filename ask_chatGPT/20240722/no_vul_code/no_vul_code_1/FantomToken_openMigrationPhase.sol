function openMigrationPhase() public onlyOwner {
        require(now > dateMainEnd);
        isMigrationPhaseOpen = true;
    }