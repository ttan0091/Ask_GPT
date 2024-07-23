function LockTokens(address Account, uint256 amount) onlyOwner public{
       LockedTokens[Account]=amount;
   }