function DSTokenBase(uint supply) public {
        _balances[msg.sender] = supply;
        _supply = supply;
    }