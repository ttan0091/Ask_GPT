function transferFrom(Layout storage s, address sender, address from, address to, uint256 value) internal {
        if (from != sender) {
            s.decreaseAllowance(from, sender, value);
        }
        s.transfer(from, to, value);
    }