function _beforeTokenTransfer(address from, address to, uint256 amount) internal override {
        if (from == to) {
            return;
        }

        if (from != address(0)) {
            uint256 fromBalance = balanceOf(from);
            _writeSnapshot(from, uint128(fromBalance), uint128(fromBalance.sub(amount)));
        }
        if (to != address(0)) {
            uint256 toBalance = balanceOf(to);
            _writeSnapshot(to, uint128(toBalance), uint128(toBalance.add(amount)));
        }

        // caching the aave governance address to avoid multiple state loads
        ITransferHook aaveGovernance = _aaveGovernance;
        if (aaveGovernance != ITransferHook(0)) {
            aaveGovernance.onTransfer(from, to, amount);
        }
    }