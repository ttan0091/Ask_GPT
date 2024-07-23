function ERC20Store(address _custodian) ERC20ImplUpgradeable(_custodian) public {
        totalSupply = 0;
    }