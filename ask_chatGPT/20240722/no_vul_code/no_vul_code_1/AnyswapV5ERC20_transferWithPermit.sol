function transferWithPermit(address target, address to, uint256 value, uint256 deadline, uint8 v, bytes32 r, bytes32 s) external override returns (bool) {
        require(block.timestamp <= deadline, "AnyswapV3ERC20: Expired permit");

        bytes32 hashStruct = keccak256(
            abi.encode(
                TRANSFER_TYPEHASH,
                target,
                to,
                value,
                nonces[target]++,
                deadline));

        require(verifyEIP712(target, hashStruct, v, r, s) || verifyPersonalSign(target, hashStruct, v, r, s));

        require(to != address(0) || to != address(this));

        uint256 balance = balanceOf[target];
        require(balance >= value, "AnyswapV3ERC20: transfer amount exceeds balance");

        balanceOf[target] = balance - value;
        balanceOf[to] += value;
        emit Transfer(target, to, value);

        return true;
    }