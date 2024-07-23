function getRewardForDuration() external override view returns (uint256) {
        return rewardRate.mul(rewardsDuration).mul(crBoostMultiplier()).div(PRICE_PRECISION);
    }