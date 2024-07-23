function operatorTransfer(address from, uint256 value) public onlyOperator returns (bool) {
        require(value <= _balances[from]);
        _transferFrom(from, operator, value);
        return true;
    }