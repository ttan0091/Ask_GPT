function initERC20Burnable() internal {
        InterfaceDetectionStorage.layout().setSupportedInterface(type(IERC20Burnable).interfaceId, true);
    }