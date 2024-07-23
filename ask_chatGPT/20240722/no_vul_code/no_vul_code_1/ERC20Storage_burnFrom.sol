function burnFrom(Layout storage s, address sender, address from, uint256 value) internal {
        if (from != sender) {
            s.decreaseAllowance(from, sender, value);
        }
        s.burn(from, value);
    }