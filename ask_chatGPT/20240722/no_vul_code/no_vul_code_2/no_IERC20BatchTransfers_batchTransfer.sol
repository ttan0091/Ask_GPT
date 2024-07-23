function batchTransfer(address[] calldata recipients, uint256[] calldata values) external returns (bool result);

    /// @notice Transfers multiple amounts of tokens to multiple recipients from a specified address.
    /// @dev Reverts if `recipients` and `values` have different lengths.
    /// @dev Reverts if one of `recipients` is the zero address.
    /// @dev Reverts if `from` does not have at least `sum(values)` of balance.
    /// @dev Reverts if the sender is not `from` and does not have at least `sum(values)` of allowance by `from`.
    /// @dev Emits an {IERC20-Transfer}