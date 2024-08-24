```solidity
function unstake(uint128 validatorId, uint128 amount) public {
    require(validatorId < validatorsN, "Invalid validator");
    Validator storage v = validators[validatorId];
    Staking storage s = v.stakings[msg.sender];
    require(s.staked >= amount, "Staked is less than amount provided");
    bool isValidator = msg.sender == v._address;
    // only update if the validator is enabled, otherwise the global shares were already excluded during disablement
    uint128 validatorSharesRemove = tokensToShares(amount, v.exchangeRate);
    require(validatorSharesRemove > 0, "Unstake amount is too small");

    if (v.disabledEpoch == 0) {
        updateGlobalExchangeRate();
        updateValidator(v);
        // if validator is enabled and the program has not ended -> check for unstaking beyond max cap
        if (isValidator && endEpoch > block.number) {
            uint128 newValidatorStaked = s.staked - amount;
            uint128 newValidatorMaxCap = newValidatorStaked * maxCapMultiplier;
            uint128 delegated = v.delegated - s.staked;
            require(delegated <= newValidatorMaxCap, "Cannot unstake beyond max cap");
            require(newValidatorStaked >= validatorMinStakedRequired, "Cannot unstake beyond minimum required");
        }

        // update global shares #
        uint128 globalSharesRemove = tokensToShares(amount, globalExchangeRate);
        require(globalSharesRemove > 0, "Unstake amount is too small");
        totalGlobalShares -= globalSharesRemove;
        v.globalShares -= globalSharesRemove;

        // update validator shares #
        v.totalShares -= validatorSharesRemove;
        v.delegated -= amount;
    }
    s.shares -= validatorSharesRemove;
    s.staked -= amount;

    // create unstaking instance
    uint128 coolDownEnd = v.disabledEpoch != 0 ? v.disabledEpoch : uint128(block.number);
    coolDownEnd += (isValidator ? validatorCoolDown : delegatorCoolDown);
    v.unstakings[msg.sender].push(Unstaking(coolDownEnd, amount));
    emit Unstaked(validatorId, msg.sender, amount);
}
```