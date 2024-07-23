function createProxy(bytes32 userSalt) external returns (address) {
        // deployment will fail and this function will revert if contract `salt` is not unique
        bytes32 salt = getSalt(msg.sender, userSalt);
        address createdContract = address(new ClonableBeaconProxy{ salt: salt }());
        return createdContract;
    }