function getAdminAddresses(string memory class) public view returns(address[] memory) {
        bytes32 classHash = getClassHash(class);
        return getItemAddresses(classHash);
    }