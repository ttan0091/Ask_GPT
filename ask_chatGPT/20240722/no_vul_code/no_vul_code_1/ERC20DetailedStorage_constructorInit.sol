function constructorInit(Layout storage s, string memory tokenName, string memory tokenSymbol, uint8 tokenDecimals) internal {
        s.tokenName = tokenName;
        s.tokenSymbol = tokenSymbol;
        s.tokenDecimals = tokenDecimals;
        InterfaceDetectionStorage.layout().setSupportedInterface(type(IERC20Detailed).interfaceId, true);
    }