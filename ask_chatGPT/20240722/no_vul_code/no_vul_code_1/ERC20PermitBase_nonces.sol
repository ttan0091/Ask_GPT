function nonces(address owner) external view override returns (uint256) {
        return ERC20PermitStorage.layout().nonces(owner);
    }