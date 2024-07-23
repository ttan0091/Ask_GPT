function withdrawEther(uint256 amount) public {
		require(owner == msg.sender);
		owner.transfer(amount);
	}