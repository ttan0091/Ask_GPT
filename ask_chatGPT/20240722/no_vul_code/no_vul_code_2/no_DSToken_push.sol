function push(address dst, uint wad) public {
        transferFrom(msg.sender, dst, wad);
    }