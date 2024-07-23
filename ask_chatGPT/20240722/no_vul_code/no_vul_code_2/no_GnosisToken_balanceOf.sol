function balanceOf(address _owner)
        constant
        public
        returns (uint256)
    {
        return balances[_owner];
    }