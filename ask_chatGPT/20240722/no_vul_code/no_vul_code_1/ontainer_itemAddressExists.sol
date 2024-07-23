function itemAddressExists(bytes32 id, address oneAddress) internal view returns(bool){
        for(uint256 i = 0; i < container[id].addresses.length; i++){
            if(container[id].addresses[i] == oneAddress)
                return true;
        }
        return false;
    }