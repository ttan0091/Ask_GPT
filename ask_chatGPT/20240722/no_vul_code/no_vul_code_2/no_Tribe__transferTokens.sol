function _transferTokens(address src, address dst, uint96 amount) internal {
        require(src != address(0), "Tribe: cannot transfer from the zero address");
        require(dst != address(0), "Tribe: cannot transfer to the zero address");

        balances[src] = sub96(balances[src], amount, "Tribe: transfer amount exceeds balance");
        balances[dst] = add96(balances[dst], amount, "Tribe: transfer amount overflows");
        emit Transfer(src, dst, amount);

        _moveDelegates(delegates[src], delegates[dst], amount);
    }