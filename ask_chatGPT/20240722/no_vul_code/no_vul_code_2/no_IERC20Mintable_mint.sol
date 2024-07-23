function mint(address to, uint256 value) external;

    /// @notice Mints multiple amounts of tokens to multiple recipients, increasing the total supply.
    /// @dev Reverts if `recipients` and `values` have different lengths.
    /// @dev Reverts if one of `recipients` is the zero address.
    /// @dev Reverts if the total supply overflows.
    /// @dev Emits an {IERC20-Transfer}