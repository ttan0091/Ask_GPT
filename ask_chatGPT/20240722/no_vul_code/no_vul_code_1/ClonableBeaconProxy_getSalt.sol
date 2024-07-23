function getSalt(address user, bytes32 userSalt) public pure returns (bytes32) {
        return keccak256(abi.encode(user, userSalt));
    }