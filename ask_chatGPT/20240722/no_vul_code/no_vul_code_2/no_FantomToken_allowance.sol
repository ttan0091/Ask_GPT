function allowance(address _owner, address _spender) public view returns (uint) {
        return allowed[_owner][_spender];
    }