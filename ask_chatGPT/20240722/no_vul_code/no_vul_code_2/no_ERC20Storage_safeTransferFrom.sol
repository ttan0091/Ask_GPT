function safeTransferFrom(Layout storage s, address sender, address from, address to, uint256 value, bytes calldata data) internal {
        s.transferFrom(sender, from, to, value);
        if (to.isContract()) {
            _callOnERC20Received(sender, from, to, value, data);
        }
    }