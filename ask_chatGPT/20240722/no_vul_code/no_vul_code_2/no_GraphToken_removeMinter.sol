function removeMinter(address _account) external onlyGovernor {
        _removeMinter(_account);
    }