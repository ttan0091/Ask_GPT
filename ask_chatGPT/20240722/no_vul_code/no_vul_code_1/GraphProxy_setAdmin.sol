function setAdmin(address _newAdmin) external override ifAdmin {
        require(_newAdmin != address(0), "Admin cant be the zero address");
        _setAdmin(_newAdmin);
    }