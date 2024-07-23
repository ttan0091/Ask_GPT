function acceptUpgradeAndCall(bytes calldata data) external override ifAdminOrPendingImpl {
        _acceptUpgrade();
        // solhint-disable-next-line avoid-low-level-calls
        (bool success, ) = _getImplementation().delegatecall(data);
        require(success, "Impl call failed");
    }