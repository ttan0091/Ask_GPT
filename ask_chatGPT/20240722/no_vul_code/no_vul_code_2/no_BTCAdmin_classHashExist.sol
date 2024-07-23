function classHashExist(bytes32 aHash) private view returns(bool){
        for(uint256 i = 0; i < classHashArray.length; i++)
            if(classHashArray[i] == aHash) return true;
        return false;
    }