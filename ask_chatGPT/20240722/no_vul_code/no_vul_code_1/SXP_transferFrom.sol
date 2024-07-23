function transferFrom(address sender, address recipient, uint256 amount) external validLock permissionCheck returns (bool) {
        _transfer(sender, recipient, amount);
        address spender = _msgSender();
        uint256 spenderAllowance = _allowances[sender][spender];
        if (spenderAllowance != uint256(-1)) {
            _approve(sender, spender, spenderAllowance.sub(amount, "The transfer amount exceeds allowance"));
        }
        return true;
    }