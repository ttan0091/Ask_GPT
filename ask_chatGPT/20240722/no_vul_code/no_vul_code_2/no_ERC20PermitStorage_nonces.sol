function nonces(Layout storage s, address owner) internal view returns (uint256 nonce) {
        return s.accountNonces[owner];
    }