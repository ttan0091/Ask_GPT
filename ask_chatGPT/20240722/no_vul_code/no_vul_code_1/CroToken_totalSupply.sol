function totalSupply() public view returns (uint) {
        return totalSupply_.sub(balances[address(0)]);
    }