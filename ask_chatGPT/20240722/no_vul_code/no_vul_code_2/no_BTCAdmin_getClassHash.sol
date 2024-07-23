function getClassHash(string memory class) private view returns (bytes32){
        bytes32 classHash = keccak256(abi.encodePacked(class));
        require(classHashExist(classHash), "invalid class");
        return classHash;
    }