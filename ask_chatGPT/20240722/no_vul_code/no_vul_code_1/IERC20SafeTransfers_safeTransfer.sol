function safeTransfer(address to, uint256 value, bytes calldata data) external returns (bool result);

    /// @notice Transfers an amount of tokens to a recipient from a specified address. If the recipient is a contract, calls `onERC20Received` on it.
    /// @dev Reverts if `to` is the zero address.
    /// @dev Reverts if `from` does not have at least `value` of balance.
    /// @dev Reverts if the sender is not `from` and does not have at least `value` of allowance by `from`.
    /// @dev Reverts if `to` is a contract and the call to `onERC20Received(address,address,uint256,bytes)` fails, reverts or is rejected.
    /// @dev Emits an {IERC20-Transfer}