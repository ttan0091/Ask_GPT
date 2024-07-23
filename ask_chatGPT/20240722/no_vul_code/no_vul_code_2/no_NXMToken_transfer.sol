function transfer(address to, uint256 value) public canTransfer(to) returns (bool) {

        require(isLockedForMV[msg.sender] < now); // if not voted under governance
        require(value <= _balances[msg.sender]);
        _transfer(to, value); 
        return true;
    }