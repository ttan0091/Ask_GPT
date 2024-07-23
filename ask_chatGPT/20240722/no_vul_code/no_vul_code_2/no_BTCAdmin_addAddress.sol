function addAddress(string memory class, address oneAddress)
        public onlyOwner returns(bool){
        bytes32 classHash = getClassHash(class);
        require(classHash != STOREHASH && classHash != LOGICHASH, "wrong class");
        require(!itemAddressExists(classHash,oneAddress),"address existed already");

        bytes32 taskHash = keccak256(abi.encodePacked("addAddress", class, oneAddress));
        addItemAddress(taskHash, msg.sender);
        if(getItemAddressCount(taskHash) >= ownerRequireNum){
            addItemAddress(classHash, oneAddress);
            emit AdminChanged("addAddress", class, oneAddress, oneAddress);
            removeItem(taskHash);
            return true;
        }
        return false;
    }