function balanceOf(address _owner) public view returns (uint256 balance)`
   *
   * @param _owner the address to query the the balance for
   * @return balance an amount of tokens owned by the address specified
   */
  function balanceOf(address _owner) public view returns (uint256 balance) {
    // read the balance and return
    return tokenBalances[_owner];
  }