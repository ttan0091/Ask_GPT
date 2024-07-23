function setAudiusProxyAdminAddress(address _adminAddress) external {
        require(msg.sender == proxyAdmin, ERROR_ONLY_ADMIN);
        proxyAdmin = _adminAddress;
    }