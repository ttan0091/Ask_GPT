function notifyRewardAmount(uint256 reward)
    internal
    updateReward(address(0))
{
    historicalRewards = historicalRewards.add(reward);
    if (block.timestamp >= periodFinish) {
        rewardRate = reward.div(duration);
    } else {
        uint256 remaining = periodFinish.sub(block.timestamp);
        uint256 leftover = remaining.mul(rewardRate);
        reward = reward.add(leftover);
        rewardRate = reward.div(duration);
    }
    currentRewards = reward;
    lastUpdateTime = block.timestamp;
    periodFinish = block.timestamp.add(duration);
    emit RewardAdded(reward);
}