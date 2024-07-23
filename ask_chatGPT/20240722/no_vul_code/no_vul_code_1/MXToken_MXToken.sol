function MXToken(
    ) public {
        balanceOf[msg.sender] = totalSupply;                // Give the creator all initial tokens
    }