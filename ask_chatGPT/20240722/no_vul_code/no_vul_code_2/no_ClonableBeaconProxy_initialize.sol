function initialize(address _beacon) external {
        require(_beacon != address(0), "INVALID_BEACON");
        require(beacon == address(0), "ALREADY_INIT");
        beacon = _beacon;
    }