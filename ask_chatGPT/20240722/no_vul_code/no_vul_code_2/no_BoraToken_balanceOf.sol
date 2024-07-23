function balanceOf() public view returns (uint256) {
        return token.balanceOf(this);
    }