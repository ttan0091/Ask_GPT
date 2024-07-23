function transferPaymentTokensToUser(address user, uint256 amount) external override longShortOnly {
    try paymentToken.transfer(user, amount) returns (bool transferSuccess) {
        if (transferSuccess) {
            // If the transfer is successful return early, otherwise try to pay the user out with the amount reserved
            return;
        }
    } catch {}
    
    amountReservedInCaseOfInsufficientAaveLiquidity -= amount;
    // If this reverts (i.e., Aave unable to make payout), then the whole transaction will revert. User will not receive payment.
    lendingPool.withdraw(address(paymentToken), amount, user);
}