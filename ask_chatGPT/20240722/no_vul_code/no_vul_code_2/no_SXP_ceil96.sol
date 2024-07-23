function ceil96(uint256 n) internal pure returns (uint96) {
        if (n >= 2**96) {
            return uint96(-1);
        }
        return uint96(n);
    }