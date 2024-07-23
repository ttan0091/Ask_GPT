function allowance(Layout storage s, address owner, address spender) internal view returns (uint256 value) {
        return s.allowances[owner][spender];
    }