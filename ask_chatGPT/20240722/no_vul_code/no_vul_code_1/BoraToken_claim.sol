function claim() public {
        require(now >= releaseTime);

        uint amount = token.balanceOf(this);
        require(amount > 0);
        token.transfer(beneficiary, amount);
        Claim(beneficiary, amount, releaseTime);
    }