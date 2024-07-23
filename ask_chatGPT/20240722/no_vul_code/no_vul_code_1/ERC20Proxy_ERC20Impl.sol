function ERC20Impl(
          address _erc20Proxy,
          address _erc20Store,
          address _custodian,
          address _sweeper
    )
        CustodianUpgradeable(_custodian)
        public
    {
        require(_sweeper != 0);
        erc20Proxy = ERC20Proxy(_erc20Proxy);
        erc20Store = ERC20Store(_erc20Store);

        sweeper = _sweeper;
        sweepMsg = keccak256(address(this), "sweep");
    }