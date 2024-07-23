function _setAdmin(address _newAdmin) internal {
        address oldAdmin = _getAdmin();
        bytes32 slot = ADMIN_SLOT;
        // solhint-disable-next-line no-inline-assembly
        assembly {
            sstore(slot, _newAdmin)
        }

        emit AdminUpdated(oldAdmin, _newAdmin);
    }