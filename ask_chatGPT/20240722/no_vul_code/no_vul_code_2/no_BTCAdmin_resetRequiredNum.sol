function resetRequiredNum(string memory class, uint256 requiredNum)
        public onlyOwner returns(bool){
        bytes32 classHash = getClassHash(class);
        require((classHash == OPERATORHASH) || (classHash == OWNERHASH),"wrong class");
        if (classHash == OWNERHASH)
            require(requiredNum <= getItemAddressCount(OWNERHASH),"num larger than existed owners");

        bytes32 taskHash = keccak256(abi.encodePacked("resetRequiredNum", class, requiredNum));
        addItemAddress(taskHash, msg.sender);

        if(getItemAddressCount(taskHash) >= ownerRequireNum){
            removeItem(taskHash);
            uint256 previousNum = 0;
            if (classHash == OWNERHASH){
                previousNum = ownerRequireNum;
                ownerRequireNum = requiredNum;
            }
            else if(classHash == OPERATORHASH){
                previousNum = operatorRequireNum;
                operatorRequireNum = requiredNum;
            }else{
                revert("wrong class");
            }
            emit AdminRequiredNumChanged("resetRequiredNum", class, previousNum, requiredNum);
        }
        return true;
    }