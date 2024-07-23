function sub(uint a, uint b) internal pure returns (uint c) {
        require(b <= a);
        c = a - b;
    }