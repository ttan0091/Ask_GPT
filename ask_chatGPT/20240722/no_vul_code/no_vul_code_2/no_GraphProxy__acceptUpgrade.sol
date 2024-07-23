function _acceptUpgrade() internal {
        address _pendingImplementation = _getPendingImplementation();
        require(Address.isContract(_pendingImplementation), "Impl must be a contract");
        require(_pendingImplementation != address(0), "Impl cannot be zero address");
        require(msg.sender == _pendingImplementation, "Only pending implementation");

        _setImplementation(_pendingImplementation);
        _setPendingImplementation(address(0));
    }