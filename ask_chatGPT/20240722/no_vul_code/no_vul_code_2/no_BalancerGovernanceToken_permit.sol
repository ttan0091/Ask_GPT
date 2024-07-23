function permit(address owner, address spender, uint value, uint deadline, uint8 v, bytes32 r, bytes32 s) external {
        require(block.timestamp <= deadline, "ERR_EXPIRED_SIG");
        bytes32 digest = keccak256(
            abi.encodePacked(
                uint16(0x1901),
                DOMAIN_SEPARATOR,
                keccak256(abi.encode(PERMIT_TYPEHASH, owner, spender, value, nonces[owner]++, deadline))
            )
        );
        require(owner == _recover(digest, v, r, s), "ERR_INVALID_SIG");
        _approve(owner, spender, value);
    }