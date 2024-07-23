function depositETH() public payable {
    uint256 _pool = balance();
    uint256 _before = token.balanceOf(address(this));
    uint256 _amount = msg.value;
    WETH(address(token)).deposit{value: _amount}();
    uint256 _after = token.balanceOf(address(this));
    _amount = _after.sub(_before); // Additional check for deflationary tokens
    uint256 shares = 0;
    if (totalSupply() == 0) {
        shares = _amount;
    } else {
        shares = (_amount.mul(totalSupply())).div(_pool);
    }
    _mint(msg.sender, shares);
}