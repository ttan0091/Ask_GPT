function burnFrom(address from, uint256 value) external returns (bool result);

    /// @notice Burns multiple amounts of tokens from multiple owners, decreasing the total supply.
    /// @dev Reverts if `owners` and `values` have different lengths.
    /// @dev Reverts if an `owner` does not have at least the corresponding `value` of balance.
    /// @dev Reverts if the sender is not an `owner` and does not have at least the corresponding `value` of allowance by this `owner`.
    /// @dev Emits an {IERC20-Transfer}