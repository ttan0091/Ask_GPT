function pMintTokens(uint _mint_type, address _account, uint _tokens, uint _term) private {
        require(whitelist[_account]);
        require(_account != 0x0);
        require(_tokens > 0);
        require(_tokens <= availableToMint(), "not enough tokens available to mint");
        require(_term == 0 || _term > now, "either without lock term, or lock term must be in the future");

        // register locked tokens (will throw if no slot is found)
        if (_term > 0) registerLockedTokens(_account, _tokens, _term);

        // update
        balances[_account] = balances[_account].add(_tokens);
        balancesMinted[_account] = balancesMinted[_account].add(_tokens);
        balancesMintedByType[_account][_mint_type] = balancesMintedByType[_account][_mint_type].add(_tokens);
        tokensMinted = tokensMinted.add(_tokens);
        tokensIssuedTotal = tokensIssuedTotal.add(_tokens);

        // log event
        emit Transfer(0x0, _account, _tokens);
        emit TokensMinted(_mint_type, _account, _tokens, _term);
    }