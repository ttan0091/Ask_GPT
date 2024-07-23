function makeTradeable() public {
        require(msg.sender == owner || now > dateMainEnd + 20 weeks);
        tokensTradeable = true;
    }