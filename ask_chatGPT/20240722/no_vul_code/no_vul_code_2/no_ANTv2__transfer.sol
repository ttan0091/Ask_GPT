function _transfer(address from, address to, uint256 value) private {
        require(to != address(this) && to != address(0), "ANTV2:RECEIVER_IS_TOKEN_OR_ZERO");

        // Balance is implicitly checked with SafeMath's underflow protection
        balanceOf[from] = balanceOf[from].sub(value);
        balanceOf[to] = balanceOf[to].add(value);
        emit Transfer(from, to, value);
    }