function proxyInit(Layout storage s, string calldata tokenName, string calldata tokenSymbol, uint8 tokenDecimals) internal {
        ProxyInitialization.setPhase(PROXY_INIT_PHASE_SLOT, 1);
        s.tokenName = tokenName;
        s.tokenSymbol = tokenSymbol;
        s.tokenDecimals = tokenDecimals;
        InterfaceDetectionStorage.layout().setSupportedInterface(type(IERC20Detailed).interfaceId, true);
    }