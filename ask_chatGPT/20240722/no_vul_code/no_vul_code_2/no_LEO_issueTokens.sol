function issueTokens(uint _amount) public onlyOwner returns (bool) {
        tokenContract.generateTokens(owner, _amount);
    }