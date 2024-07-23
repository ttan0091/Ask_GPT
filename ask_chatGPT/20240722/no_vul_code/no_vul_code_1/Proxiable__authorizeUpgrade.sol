function _authorizeUpgrade(address newImplementation) internal override {
        _beforeUpgrade(newImplementation);
    }