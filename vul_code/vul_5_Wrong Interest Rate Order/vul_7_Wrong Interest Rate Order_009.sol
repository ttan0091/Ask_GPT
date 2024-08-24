function addToPosition(
    uint _id,
    uint _addMargin,
    PriceData calldata _priceData,
    bytes calldata _signature,
    address _stableVault,
    address _marginAsset,
    ERC20PermitData calldata _permitData,
    address _trader
)
    external
{
    _validateProxy(_trader);
    _checkOwner(_id, _trader);
    _checkDelay(_id, true);
    IPosition.Trade memory _trade = position.trades(_id);
    tradingExtension.validateTrade(_trade.asset, _trade.tigAsset, _trade.margin + _addMargin, _trade.leverage);
    _checkVault(_stableVault, _marginAsset);
    if (_trade.orderType != 0) revert("4"); // IsLimit
    uint _fee = _handleOpenFees(_trade.asset, _addMargin * _trade.leverage / 1e18, _trader, _trade.tigAsset);
    _handleDeposit(
        _trade.tigAsset,
        _marginAsset,
        _addMargin - _fee,
        _stableVault,
        _permitData,
        _trader
    );
    position.setAccInterest(_id);
    unchecked {
        (uint256 _price,) = tradingExtension.getVerifiedPrice(_trade.asset, _priceData, _signature);
        uint _positionSize = (_addMargin - _fee) * _trade.leverage / 1e18;
        if (_trade.direction) {
            tradingExtension.modifyLongOi(_trade.asset, _trade.tigAsset, true, _positionSize);
        } else {
            tradingExtension.modifyShortOi(_trade.asset, _trade.tigAsset, true, _positionSize);
        }
        _updateFunding(_trade.asset, _trade.tigAsset);
        _addMargin -= _fee;
        uint _newMargin = _trade.margin + _addMargin;
        uint _newPrice = _trade.price * _trade.margin / _newMargin + _price * _addMargin / _newMargin;

        position.addToPosition(
            _trade.id,
            _newMargin,
            _newPrice
        );

        emit AddToPosition(_trade.id, _newMargin, _newPrice, _trade.trader);
    }
}