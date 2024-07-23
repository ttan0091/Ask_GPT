function safeDiv(uint a, uint b) public pure returns (uint c) {
        require(b > 0,"");
        c = a / b;
    }