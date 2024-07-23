function acceptUpgrade() external override ifAdminOrPendingImpl {
        _acceptUpgrade();
    }