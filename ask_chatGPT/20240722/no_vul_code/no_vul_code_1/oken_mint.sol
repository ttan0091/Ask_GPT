function mint(address dest, uint256 amount) external onlyOwner {
        require(amount <= (totalSupply() * mintCap) / 10000, "ENS: Mint exceeds maximum amount");
        require(block.timestamp >= nextMint, "ENS: Cannot mint yet");

        nextMint = block.timestamp + minimumMintInterval;
        _mint(dest, amount);
    }