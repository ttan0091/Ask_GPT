function _withdraw(address from, uint amount, address to) internal returns (uint) {
        _burn(from, amount);
        IERC20(underlying).safeTransfer(to, amount);
        return amount;
    }