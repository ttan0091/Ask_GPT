function prefixed(bytes32 hash) internal view returns (bytes32) {
        return keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", DOMAIN_SEPARATOR, hash));
    }