function burn(uint256 _value) public returns (bool success) {
        uint256 balanceOfSender = erc20Store.balances(msg.sender);
        require(_value <= balanceOfSender);

        erc20Store.setBalance(msg.sender, balanceOfSender - _value);
        erc20Store.setTotalSupply(erc20Store.totalSupply() - _value);

        erc20Proxy.emitTransfer(msg.sender, address(0), _value);

        return true;
    }