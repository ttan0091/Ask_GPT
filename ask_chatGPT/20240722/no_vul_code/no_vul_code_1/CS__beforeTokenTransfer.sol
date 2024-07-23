function _beforeTokenTransfer(address from, address to, uint256 amount) internal virtual override {
        super._beforeTokenTransfer(from, to, amount);

        require(!isBlacklisted(from), "ERC20WithSafeTransfer: invalid sender");
        require(!isBlacklisted(to), "ERC20WithSafeTransfer: invalid recipient");
    }