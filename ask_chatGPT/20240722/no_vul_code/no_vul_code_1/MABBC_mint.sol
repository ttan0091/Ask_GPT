function mint(address _to,uint256 _amount)public hasMintPermission canMint returns (bool) {
  require (LockList[_to] == false,"ERC20: Receipient Locked !");
    totalSupply_ = totalSupply_.add(_amount);
    balances[_to] = balances[_to].add(_amount);
    emit Mint(_to, _amount);
    emit Transfer(address(0), _to, _amount);
    return true;
  }