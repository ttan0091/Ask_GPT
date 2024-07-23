function initERC20Mintable() internal {
        InterfaceDetectionStorage.layout().setSupportedInterface(type(IERC20Mintable).interfaceId, true);
    }