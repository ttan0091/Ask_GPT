function setTokenURI(string calldata uri) external {
        ContractOwnershipStorage.layout().enforceIsContractOwner(_msgSender());
        ERC20MetadataStorage.layout().setTokenURI(uri);
    }