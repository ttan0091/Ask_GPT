function totalSupply() public view returns (uint) {
        return totalSupplyAt(block.number);
    }