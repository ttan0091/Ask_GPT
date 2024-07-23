function _deposit(uint amount, address to) internal returns (uint) {
        require(underlying != address(0x0));
        _mint(to, amount);
        return amount;
    }