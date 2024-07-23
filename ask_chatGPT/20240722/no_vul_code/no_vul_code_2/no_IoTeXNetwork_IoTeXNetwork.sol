function IoTeXNetwork(uint tokenTotalAmount) {
        totalSupply_ = tokenTotalAmount;
        balances[msg.sender] = tokenTotalAmount;
        emit Transfer(address(0x0), msg.sender, tokenTotalAmount);
    }