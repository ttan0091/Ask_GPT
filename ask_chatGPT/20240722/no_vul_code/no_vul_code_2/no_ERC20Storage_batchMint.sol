function batchMint(Layout storage s, address[] memory recipients, uint256[] memory values) internal {
        uint256 length = recipients.length;
        require(length == values.length, "ERC20: inconsistent arrays");

        if (length == 0) return;

        uint256 totalValue;
        unchecked {
            for (uint256 i; i != length; ++i) {
                address to = recipients[i];
                require(to != address(0), "ERC20: mint to address(0)");

                uint256 value = values[i];
                if (value != 0) {
                    uint256 newTotalValue = totalValue + value;
                    require(newTotalValue > totalValue, "ERC20: values overflow");
                    totalValue = newTotalValue;
                    s.balances[to] += value; // balance cannot overflow if supply does not
                }
                emit Transfer(address(0), to, value);
            }

            if (totalValue != 0) {
                uint256 supply = s.supply;
                uint256 newSupply = supply + totalValue;
                require(newSupply > supply, "ERC20: supply overflow");
                s.supply = newSupply;
            }
        }
    }