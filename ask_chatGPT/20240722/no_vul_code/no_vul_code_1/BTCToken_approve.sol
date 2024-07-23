function approve(address spender, uint256 value) public whenNotPaused returns (bool){
        bool flag = logic.approveLogic(msg.sender,spender,value);
        require(flag, "approve failed");
        emit Approval(msg.sender, spender, value);
        return true;
    }