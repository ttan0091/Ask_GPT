function burn(uint value, bytes data)
    public
    {
        require(value > WITHDRAW_FEE);
        super._burn(msg.sender, value);
        
        if (WITHDRAW_FEE > 0) {
            super._mint(issuer, WITHDRAW_FEE);
        }
        uint256 burnValue = value.sub(WITHDRAW_FEE);
        burnList.push(TokenBurnData({
            value: burnValue,
            burner: msg.sender,
            data: data 
        }));
        TokenBurn(burnList.length - 1, msg.sender, burnValue, data);

    }