function permit(Layout storage st, address owner, address spender, uint256 value, uint256 deadline, uint8 v, bytes32 r, bytes32 s) internal {
        require(owner != address(0), "ERC20: permit from address(0)");
        require(block.timestamp <= deadline, "ERC20: expired permit");
        unchecked {
            bytes32 hashStruct = keccak256(abi.encode(PERMIT_TYPEHASH, owner, spender, value, st.accountNonces[owner]++, deadline));
            bytes32 hash = keccak256(abi.encodePacked("\x19\x01", DOMAIN_SEPARATOR(), hashStruct));
            address signer = ecrecover(hash, v, r, s);
            require(signer == owner, "ERC20: invalid permit");
        }
        ERC20Storage.layout().approve(owner, spender, value);
    }