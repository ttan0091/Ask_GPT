function DSAuth() public {
        owner = msg.sender;
        LogSetOwner(msg.sender);
    }