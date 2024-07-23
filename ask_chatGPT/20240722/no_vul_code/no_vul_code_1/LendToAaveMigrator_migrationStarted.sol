function migrationStarted() external view returns(bool) {
        return lastInitializedRevision != 0;
    }