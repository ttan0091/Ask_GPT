function totalSupply() public view returns (uint) {

        return _totalSupply.sub(balances[address(0)]);

    }