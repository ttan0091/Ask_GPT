function _setPendingImplementation(address _newImplementation) internal {
        address oldPendingImplementation = _getPendingImplementation();

        bytes32 slot = PENDING_IMPLEMENTATION_SLOT;
        // solhint-disable-next-line no-inline-assembly
        assembly {
            sstore(slot, _newImplementation)
        }

        emit PendingImplementationUpdated(oldPendingImplementation, _newImplementation);
    }