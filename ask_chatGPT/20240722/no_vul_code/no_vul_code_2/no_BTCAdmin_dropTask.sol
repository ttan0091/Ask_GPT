function dropTask(bytes32 taskHash)
    public onlyOwner returns (bool){
        removeItem(taskHash);
        emit AdminTaskDropped(taskHash);
        return true;
    }