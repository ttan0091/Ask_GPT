function init() internal {
        InterfaceDetectionStorage.layout().setSupportedInterface(type(IERC20Permit).interfaceId, true);
    }