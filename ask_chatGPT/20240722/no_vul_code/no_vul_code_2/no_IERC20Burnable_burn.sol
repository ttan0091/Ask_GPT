function burn(uint256 value) external returns (bool result);

    /// @notice Burns an amount of tokens from a specified address, decreasing the total supply.
    /// @dev Reverts if `from` does not have at least `value` of balance.
    /// @dev Reverts if the sender is not `from` and does not have at least `value` of allowance by `from`.
    /// @dev Emits an {IERC20-Transfer}