function balanceOf(address _owner) public view returns (uint256 balance) {
        return erc20Store.balances(_owner);
    }