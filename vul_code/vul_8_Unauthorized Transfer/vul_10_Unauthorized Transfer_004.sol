```solidity
function transferNotionalFrom(address f, address t, uint256 a) external onlyAdmin(admin) returns (bool) {
    Vault memory from = vaults[f];
    Vault memory to = vaults[t];

    require(from.notional >= a, "amount exceeds available balance");

    uint256 yield;
    uint256 interest;
    uint256 exchangeRate = CErc20(cTokenAddr).exchangeRateCurrent();

    // if market has matured, calculate marginal interest between the maturity rate and previous position
    // otherwise, calculate marginal exchange rate between current and previous exchange rate.
    if (matured) {
        // calculate marginal interest
        yield = ((maturityRate * 1e26) / from.exchangeRate) - 1e26;
    } else {
        yield = ((exchangeRate * 1e26) / from.exchangeRate) - 1e26;
    }

    interest = (yield * from.notional) / 1e26;
    // remove amount from position, add interest to position, reset cToken exchange rate
    from.redeemable += interest;
    from.notional -= a;
    from.exchangeRate = exchangeRate;

    vaults[f] = from;

    // transfer notional to address "t", calculate interest if necessary
    if (to.notional > 0) {
        uint256 newVaultInterest;

        // if market has matured, calculate marginal interest between the maturity rate and previous position
        // otherwise, calculate marginal
        if (matured) {
            // calculate marginal interest
            yield = ((maturityRate * 1e26) / to.exchangeRate) - 1e26;
        } else {
            yield = ((exchangeRate * 1e26) / to.exchangeRate) - 1e26;
        }

        newVaultInterest = (yield * to.notional) / 1e26;
        // add interest and amount to position, reset cToken exchange rate
        to.redeemable += newVaultInterest;
        to.notional += a;
    } else {
        to.notional += a;
    }

    to.exchangeRate = exchangeRate;
    vaults[t] = to;

    return true;
}
```