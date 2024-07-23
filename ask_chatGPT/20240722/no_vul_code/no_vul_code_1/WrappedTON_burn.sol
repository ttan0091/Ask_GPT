function burn(uint256 amount, TonAddress memory addr) external {
      require(allowBurn, "Burn is currently disabled");
      _burn(msg.sender, amount);
      emit SwapEthToTon(msg.sender, addr.workchain, addr.address_hash, amount);
    }