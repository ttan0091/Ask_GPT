function burnTokens(uint _amount) public onlyOwner returns (bool) {
        tokenContract.destroyTokens(owner, _amount);
    }