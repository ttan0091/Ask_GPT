function delegateBySig(
        address delegatee,
        uint256 nonce,
        uint256 expiry,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external {
        bytes32 domainSeparator = keccak256(
            abi.encode(DOMAIN_TYPEHASH, keccak256(bytes(name())), block.chainid, address(this))
        );
        bytes32 structHash = keccak256(abi.encode(DELEGATION_TYPEHASH, delegatee, nonce, expiry));
        bytes32 digest = keccak256(abi.encodePacked("\x19\x01", domainSeparator, structHash));
        address signatory = ecrecover(digest, v, r, s);

        require(signatory != address(0), "FLOKI:delegateBySig:INVALID_SIGNATURE: Received signature was invalid.");
        require(block.timestamp <= expiry, "FLOKI:delegateBySig:EXPIRED_SIGNATURE: Received signature has expired.");
        require(nonce == nonces[signatory]++, "FLOKI:delegateBySig:INVALID_NONCE: Received nonce was invalid.");

        return _delegate(signatory, delegatee);
    }