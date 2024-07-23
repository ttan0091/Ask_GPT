function depositWithTransferPermit(address target, uint256 value, uint256 deadline, uint8 v, bytes32 r, bytes32 s, address to) external returns (uint) {
        IERC20(underlying).transferWithPermit(target, address(this), value, deadline, v, r, s);
        return _deposit(value, to);
    }