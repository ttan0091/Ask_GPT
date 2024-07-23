function availableToMint() public view returns (uint) {
        return MAX_TOTAL_TOKEN_SUPPLY.sub(TOKEN_MAIN_CAP).sub(tokensMinted);
    }