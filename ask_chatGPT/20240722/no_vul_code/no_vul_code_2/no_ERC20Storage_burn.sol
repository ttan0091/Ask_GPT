function burn(Layout storage s, address from, uint256 value) internal {
        if (value != 0) {
            uint256 balance = s.balances[from];
            unchecked {
                uint256 newBalance = balance - value;
                require(newBalance < balance, "ERC20: insufficient balance");
                s.balances[from] = newBalance;
                s.supply -= value; // will not underflow if balance does not
            }
        }

        emit Transfer(from, address(0), value);
    }