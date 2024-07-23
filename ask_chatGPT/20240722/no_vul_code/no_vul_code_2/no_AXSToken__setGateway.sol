function _setGateway(address _mainchainGateway) internal {
    require(
      _mainchainGateway != address(0),
      "ERC20GatewayWhitelist: setting gateway to the zero address"
    );
    mainchainGateway = _mainchainGateway;
  }