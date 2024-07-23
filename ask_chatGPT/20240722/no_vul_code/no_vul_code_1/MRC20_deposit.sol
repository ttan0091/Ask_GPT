function deposit(address user, uint256 amount) public onlyOwner {
        // check for amount and user
        require(
            amount > 0 && user != address(0x0),
            "Insufficient amount or invalid user"
        );

        // input balance
        uint256 input1 = balanceOf(user);

        // transfer amount to user
        address payable _user = address(uint160(user));
        _user.transfer(amount);

        currentSupply = currentSupply.add(amount);

        // deposit events
        emit Deposit(token, user, amount, input1, balanceOf(user));
    }