function transfer(address to, uint256 value) public whenNotPaused returns (bool) {
        bool flag = logic.transferLogic(msg.sender,to,value);
        require(flag, "transfer failed");
        emit Transfer(msg.sender,to,value);
        return true;
    }