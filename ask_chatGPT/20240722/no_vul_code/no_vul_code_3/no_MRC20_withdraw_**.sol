function withdraw(uint256 amount) public payable {
        address user = msg.sender;
        // input balance
        uint256 input = balanceOf(user);

        currentSupply = currentSupply.sub(amount);
        // check for amount
        require(
            amount > 0 && msg.value == amount,
            "Insufficient amount"
        );

        // withdraw event
        emit Withdraw(token, user, amount, input, balanceOf(user));
    }