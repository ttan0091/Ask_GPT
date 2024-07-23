function modifyAddress(string memory class, address oldAddress, address newAddress)
        internal onlyOwner returns(bool){
        bytes32 classHash = getClassHash(class);
        require(!itemAddressExists(classHash,newAddress),"address existed already");
        require(itemAddressExists(classHash,oldAddress),"address not existed");
        bytes32 taskHash = keccak256(abi.encodePacked("modifyAddress", class, oldAddress, newAddress));
        addItemAddress(taskHash, msg.sender);
        if(getItemAddressCount(taskHash) >= ownerRequireNum){
            replaceItemAddress(classHash, oldAddress, newAddress);
            emit AdminChanged("modifyAddress", class, oldAddress, newAddress);
            removeItem(taskHash);
            return true;
        }
        return false;
    }