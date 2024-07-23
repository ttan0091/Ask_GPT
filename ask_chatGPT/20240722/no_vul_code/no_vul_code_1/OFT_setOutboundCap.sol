function setOutboundCap(uint16 chainId, uint256 cap) external onlyOwner {
        chainIdToOutboundCap[chainId] = cap;
        emit SetOutboundCap(chainId, cap);
    }