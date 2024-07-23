function modifyAdminAddress(string memory class, address oldAddress, address newAddress) public whenPaused{
        require(newAddress != address(0x0), "wrong address");
        bool flag = modifyAddress(class, oldAddress, newAddress);
        if(flag){
            bytes32 classHash = keccak256(abi.encodePacked(class));
            if(classHash == LOGICHASH){
                logic = HBTCLogic(newAddress);
            }else if(classHash == STOREHASH){
                logic.resetStoreLogic(newAddress);
            }
        }
    }