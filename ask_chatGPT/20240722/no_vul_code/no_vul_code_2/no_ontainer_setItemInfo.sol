function setItemInfo(bytes32 id, uint256 itemType, uint256 status) internal{
        container[id].itemType = itemType;
        container[id].status = status;
    }