function queueNewRewards(uint256 _rewards) external nonReentrant {
    require(rewardDistributors[cvxCrv][msg.sender], "!authorized");
    require(_rewards > 0, "No reward");
    RewardData storage rdata = rewardData[cvxCrv];
    IERC20(cvxCrv).safeTransferFrom(msg.sender, address(this), _rewards);
    _rewards = _rewards.add(queuedCvxCrvRewards);
    if (block.timestamp >= rdata.periodFinish) {
        _notifyReward(cvxCrv, _rewards);
        queuedCvxCrvRewards = 0;
        return;
    }
    // et = now - (finish - duration)
    uint256 elapsedTime = block.timestamp.sub(rdata.periodFinish.sub(rewardsDuration.to32()));
    // current at now: rewardRate * elapsedTime
    uint256 currentAtNow = rdata.rewardRate * elapsedTime;
    uint256 queuedRatio = currentAtNow.mul(1000).div(_rewards);
    if (queuedRatio < newRewardRatio) {
        _notifyReward(cvxCrv, _rewards);
        queuedCvxCrvRewards = 0;
    } else {
        queuedCvxCrvRewards = _rewards;
    }
}