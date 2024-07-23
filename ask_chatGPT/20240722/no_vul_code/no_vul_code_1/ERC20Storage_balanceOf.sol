function balanceOf(Layout storage s, address owner) internal view returns (uint256 balance) {
        return s.balances[owner];
    }