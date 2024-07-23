function setTaskInfo(bytes32 taskHash, uint256 taskType, uint256 status) external onlyCaller{
        setItemInfo(taskHash, taskType, status);
    }