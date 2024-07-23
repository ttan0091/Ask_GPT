function setWhitelist(address addr, bool isWhitelist) external onlyOwner {
        whitelist[addr] = isWhitelist;
        emit SetWhitelist(addr, isWhitelist);
    }