function canUpgrade() public view returns (bool) {
        return released && super.canUpgrade();
    }