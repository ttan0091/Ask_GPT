function mintTokensMultiple(uint _mint_type, address[] _accounts, uint[] _tokens) public onlyOwner {
        require(_accounts.length == _tokens.length);
        for (uint i; i < _accounts.length; i++) {
            pMintTokens(_mint_type, _accounts[i], _tokens[i], 0);
        }
    }