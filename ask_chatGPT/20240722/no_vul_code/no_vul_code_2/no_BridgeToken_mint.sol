function mint(
        address to,
        uint256 amount,
        address feeAddress,
        uint256 feeAmount,
        bytes32 originTxId
    ) public {
        require(bridgeRoles.has(msg.sender), "Unauthorized.");
        _mint(to, amount);
        if (feeAmount > 0) {
            _mint(feeAddress, feeAmount);
        }
        emit Mint(to, amount, feeAddress, feeAmount, originTxId);
    }