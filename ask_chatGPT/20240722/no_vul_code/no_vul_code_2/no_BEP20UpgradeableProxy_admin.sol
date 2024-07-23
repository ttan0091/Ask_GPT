function admin() external ifAdmin returns (address) {
        return _admin();
    }