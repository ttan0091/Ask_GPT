function setFXSEthOracle(address _fxs_oracle_addr, address _weth_address) public onlyByOwnerOrGovernance {
        fxs_eth_oracle_address = _fxs_oracle_addr;
        fxsEthOracle = UniswapPairOracle(_fxs_oracle_addr);
        weth_address = _weth_address;
    }