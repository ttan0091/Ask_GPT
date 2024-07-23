function getAllowed(address owner, address spender) public view returns (uint256 remaining){
        return store.getAllowed(owner,spender);
    }