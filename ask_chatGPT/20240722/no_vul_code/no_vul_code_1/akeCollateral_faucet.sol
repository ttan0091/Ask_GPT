function faucet() public {
    	if (used[msg.sender] == false) {
    		used[msg.sender] = true;
    		_mint(msg.sender, 1000 * (10 ** uint256(decimals)));
    	}
    }