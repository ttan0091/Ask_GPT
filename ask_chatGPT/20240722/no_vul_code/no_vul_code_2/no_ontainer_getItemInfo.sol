function getItemInfo(bytes32 id) internal view returns(uint256, uint256, uint256){
        return (container[id].itemType, container[id].status, container[id].addresses.length);
    }