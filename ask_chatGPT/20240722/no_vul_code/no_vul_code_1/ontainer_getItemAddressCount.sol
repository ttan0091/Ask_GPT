function getItemAddressCount(bytes32 id) internal view returns(uint256){
        return container[id].addresses.length;
    }