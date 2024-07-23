function totalSupply() public constant returns (uint) {
        return totalSupplyAt(block.number);
    }