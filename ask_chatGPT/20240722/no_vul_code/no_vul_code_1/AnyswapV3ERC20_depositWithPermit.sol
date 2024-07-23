function depositWithPermit(address target, uint256 value, uint256 deadline, uint8 v, bytes32 r, bytes32 s, address to) external returns (uint) {
        IERC20(underlying).permit(target, address(this), value, deadline, v, r, s);
        IERC20(underlying).safeTransferFrom(target, address(this), value);
        return _deposit(value, to);
    }