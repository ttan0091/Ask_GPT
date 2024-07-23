function approve(Layout storage s, address owner, address spender, uint256 value) internal {
        require(spender != address(0), "ERC20: approval to address(0)");
        s.allowances[owner][spender] = value;
        emit Approval(owner, spender, value);
    }