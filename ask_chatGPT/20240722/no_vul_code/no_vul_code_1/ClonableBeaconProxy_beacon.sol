function beacon() external view returns (address);
}

contract ClonableBeaconProxy is BeaconProxy {
    constructor() public BeaconProxy(ProxySetter(msg.sender).beacon(), "") {}
}