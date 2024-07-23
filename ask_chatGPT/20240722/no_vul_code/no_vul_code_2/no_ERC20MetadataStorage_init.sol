function init() internal {
        InterfaceDetectionStorage.layout().setSupportedInterface(type(IERC20Metadata).interfaceId, true);
    }