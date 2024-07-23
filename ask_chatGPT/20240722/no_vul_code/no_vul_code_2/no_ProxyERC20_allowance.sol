function allowance(
        address owner,
        address spender
    )
        public
        view
        returns (uint256)
    {
        // Immutable static call from target contract
        return IERC20(target).allowance(owner, spender);
    }