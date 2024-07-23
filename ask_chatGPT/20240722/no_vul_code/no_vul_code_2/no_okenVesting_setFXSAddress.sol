function setFXSAddress(address FXS_address) public {
        require(msg.sender == _owner, "must be set by the owner");
        _FXS_contract_address = FXS_address;
        FXS = ERC20(FXS_address);
    }