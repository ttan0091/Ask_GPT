function cancelTask(bytes32 taskHash)  public returns(uint256){
        require(itemAddressExists(OPERATORHASH, msg.sender), "wrong operator");
        return logic.cancelTask(taskHash);
    }