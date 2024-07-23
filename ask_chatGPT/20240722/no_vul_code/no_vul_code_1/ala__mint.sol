function _mint(address account, uint256 amount) internal override {
        super._mint(account, amount);
        _totalMinted = _totalMinted.add(amount);
    }