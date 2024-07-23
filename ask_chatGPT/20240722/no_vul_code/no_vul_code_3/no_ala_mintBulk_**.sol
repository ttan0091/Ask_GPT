function mintBulk(address[] memory accounts, uint256[] memory amounts)
        public
        onlyMinter
        returns (bool)
    {
        require(accounts.length == amounts.length, "arrays must have same length");
        for (uint256 i = 0; i < accounts.length; i++) {
            require(amounts[i] > 0, "amount must be greater than 0");
            _mint(accounts[i], amounts[i]);
        }
        return true;
    }