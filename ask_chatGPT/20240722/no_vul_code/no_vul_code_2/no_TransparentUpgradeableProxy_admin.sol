function admin() external ifAdmin returns (address admin_) {
        admin_ = _getAdmin();
    }