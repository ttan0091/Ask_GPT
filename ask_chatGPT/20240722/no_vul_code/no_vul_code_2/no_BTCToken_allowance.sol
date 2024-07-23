function allowance(address owner, address spender) public view returns (uint256 remaining){
        return logic.getAllowed(owner,spender);
    }