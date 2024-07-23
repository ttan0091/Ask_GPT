function transfer(address to, uint256 value) public returns (bool) {
        // Mutable state call requires the proxy to tell the target who the msg.sender is.
        target.setMessageSender(msg.sender);

        // Forward the ERC20 call to the target contract
        IERC20(target).transfer(to, value);

        // Event emitting will occur via Synthetix.Proxy._emit()
        return true;
    }