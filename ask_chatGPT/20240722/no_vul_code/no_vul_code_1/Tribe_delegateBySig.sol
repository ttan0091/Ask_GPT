function delegateBySig(address delegatee, uint nonce, uint expiry, uint8 v, bytes32 r, bytes32 s) public {
        bytes32 domainSeparator = keccak256(abi.encode(DOMAIN_TYPEHASH, keccak256(bytes(name)), getChainId(), address(this)));
        bytes32 structHash = keccak256(abi.encode(DELEGATION_TYPEHASH, delegatee, nonce, expiry));
        bytes32 digest = keccak256(abi.encodePacked("\x19\x01", domainSeparator, structHash));
        address signatory = ecrecover(digest, v, r, s);
        require(signatory != address(0), "Tribe: invalid signature");
        require(nonce == nonces[signatory]++, "Tribe: invalid nonce");
        // solhint-disable-next-line not-rely-on-time
        require(block.timestamp <= expiry, "Tribe: signature expired");
        return _delegate(signatory, delegatee);
    }