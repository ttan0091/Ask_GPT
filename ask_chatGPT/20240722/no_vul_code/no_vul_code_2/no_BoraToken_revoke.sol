function revoke() public {
        require(revocable);
        require(msg.sender == donor);

        uint amount = token.balanceOf(this);
        require(amount > 0);
        token.transfer(donor, amount);
        Revoke(donor, amount);
    }