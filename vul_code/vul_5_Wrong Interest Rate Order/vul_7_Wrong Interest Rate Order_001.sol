function accrueAccount(address _account) public {
    _distributeReward(_account);
    accrue();
    _accrueAccountInterest(_account);

    if (_account != feeRecipient()) {
        _accrueAccountInterest(feeRecipient());
    }
}