function allowance(address _owner, address _spender) constant returns (uint) {
        return allowed[_owner][_spender];
    }