function transferReserveToTreasury(uint16[] calldata currencies)
    external
    override
    onlyManagerContract
    nonReentrant
    returns (uint256[] memory)
{
    uint256[] memory amountsTransferred = new uint256[](currencies.length);

    for (uint256 i; i < currencies.length; i++) {
        // Prevents duplicate currency IDs
        if (i > 0) require(currencies[i] > currencies[i - 1]);

        uint16 currencyId = currencies[i];
        _checkValidCurrency(currencyId);

        // Reserve buffer amount in INTERNAL_TOKEN_PRECISION
        int256 bufferInternal = SafeInt256.toInt(reserveBuffer[currencyId]);

        // Reserve requirement not defined
        if (bufferInternal == 0) continue;

        // prettier-ignore
        (int256 reserveInternal, /* */, /* */, /* */) = BalanceHandler.getBalanceStorage(Constants.RESERVE_ACCOUNT, currencyId);

        // Do not withdraw anything if reserve is below or equal to reserve requirement
        if (reserveInternal <= bufferInternal) continue;

        Token memory asset = TokenHandler.getAssetToken(currencyId);

        // Actual reserve amount allowed to be redeemed and transferred
        int256 assetInternalRedeemAmount = reserveInternal.subNoNeg(bufferInternal);

        // Redeems cTokens and transfer underlying to treasury manager contract
        amountsTransferred[i] = _redeemAndTransfer(
            currencyId,
            asset,
            assetInternalRedeemAmount
        );

        // Updates the reserve balance
        BalanceHandler.harvestExcessReserveBalance(
            currencyId,
            reserveInternal,
            assetInternalRedeemAmount
        );
    }

    // NOTE: TreasuryManager contract will emit an AssetsHarvested event
    return amountsTransferred;
}