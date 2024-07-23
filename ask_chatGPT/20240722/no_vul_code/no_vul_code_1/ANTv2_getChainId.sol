function getChainId() public pure returns (uint256 chainId) {
        assembly { chainId := chainid() }
    }