function totalSupply() public view returns (uint) {
        return address(this).balance;
    }