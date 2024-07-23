function initialize(
        address migrator,
        address distributor,
        ITransferHook aaveGovernance
    ) external initializer {

        uint256 chainId;

        //solium-disable-next-line
        assembly {
            chainId := chainid()
        }

        DOMAIN_SEPARATOR = keccak256(abi.encode(
            EIP712_DOMAIN,
            keccak256(bytes(NAME)),
            keccak256(EIP712_REVISION),
            chainId,
            address(this)
        ));
        _name = NAME;
        _symbol = SYMBOL;
        _setupDecimals(DECIMALS);
        _aaveGovernance = aaveGovernance;
        _mint(migrator, MIGRATION_AMOUNT);
        _mint(distributor, DISTRIBUTION_AMOUNT);
    }