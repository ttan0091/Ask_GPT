function _inflationCalculate(uint256 _intervalsSinceLastMint) private view returns (uint256) {
        // The inflation amount
        uint256 inflationTokenAmount = 0;
        // Only update  if last interval has passed and inflation rate is > 0
        if(_intervalsSinceLastMint > 0) {
            // Optimisation
            uint256 inflationRate = getInflationIntervalRate();
            if(inflationRate > 0) {
                // Get the total supply now
                uint256 totalSupplyCurrent = totalSupply();
                uint256 newTotalSupply = totalSupplyCurrent;
                // Compute inflation for total inflation intervals elapsed
                for (uint256 i = 0; i < _intervalsSinceLastMint; i++) {
                    newTotalSupply = newTotalSupply.mul(inflationRate).div(10**18);
                }
                // Return inflation amount
                inflationTokenAmount = newTotalSupply.sub(totalSupplyCurrent);
            }
        }
        // Done
        return inflationTokenAmount;
    }