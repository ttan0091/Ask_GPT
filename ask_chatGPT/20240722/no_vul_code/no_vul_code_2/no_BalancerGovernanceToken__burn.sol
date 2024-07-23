function _burn(address account, uint256 value) internal virtual override {
        _updateAccountSnapshot(account);
        _updateTotalSupplySnapshot();

        super._burn(account, value);
    }