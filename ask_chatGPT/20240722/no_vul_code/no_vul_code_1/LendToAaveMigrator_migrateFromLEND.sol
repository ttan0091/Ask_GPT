function migrateFromLEND(uint256 amount) external {
        require(lastInitializedRevision != 0, "MIGRATION_NOT_STARTED");

        _totalLendMigrated = _totalLendMigrated.add(amount);
        LEND.transferFrom(msg.sender, address(this), amount);
        AAVE.transfer(msg.sender, amount.div(LEND_AAVE_RATIO));
        emit LendMigrated(msg.sender, amount);
    }