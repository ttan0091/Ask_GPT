function BoraToken(uint256 _supply) public {
        require(_supply != 0);
        balances[msg.sender] = _supply;
        totalSupply_ = _supply;
        name = 'BORA';
        symbol = 'BORA';
        decimals = 18;
        Transfer(address(0), msg.sender, _supply);
    }