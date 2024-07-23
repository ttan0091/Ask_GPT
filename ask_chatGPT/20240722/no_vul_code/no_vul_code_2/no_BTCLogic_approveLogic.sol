function approveLogic(address sender,address spender,uint256 value)  external onlyCaller returns(bool success){
        require(spender != address(0), "spender address zero");
        require(value > 0, "value need > 0");
        require(address(store) != address(0), "dataStore address error");

        store.setAllowed(sender,spender,value);
        return true;
    }