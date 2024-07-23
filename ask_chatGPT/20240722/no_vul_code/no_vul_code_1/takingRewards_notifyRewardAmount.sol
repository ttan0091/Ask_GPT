function notifyRewardAmount(uint256 reward) external override onlyRewardsDistribution updateReward(address(0)) {
        // Needed to make compiler happy

        
        // if (block.timestamp >= periodFinish) {
        //     rewardRate = reward.mul(crBoostMultiplier()).div(rewardsDuration).div(PRICE_PRECISION);
        // } else {
        //     uint256 remaining = periodFinish.sub(block.timestamp);
        //     uint256 leftover = remaining.mul(rewardRate);
        //     rewardRate = reward.mul(crBoostMultiplier()).add(leftover).div(rewardsDuration).div(PRICE_PRECISION);
        // }

        // // Ensure the provided reward amount is not more than the balance in the contract.
        // // This keeps the reward rate in the right range, preventing overflows due to
        // // very high values of rewardRate in the earned and rewardsPerToken functions;
        // // Reward + leftover must be less than 2^256 / 10^18 to avoid overflow.
        // uint balance = rewardsToken.balanceOf(address(this));
        // require(rewardRate <= balance.div(rewardsDuration), "Provided reward too high");

        // lastUpdateTime = block.timestamp;
        // periodFinish = block.timestamp.add(rewardsDuration);
        // emit RewardAdded(reward);
    }