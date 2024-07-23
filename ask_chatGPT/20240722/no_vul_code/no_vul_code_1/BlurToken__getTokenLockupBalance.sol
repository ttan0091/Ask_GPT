function _getTokenLockupBalance(address account) internal view returns (uint256) {
        uint256 balance;
        uint256 lockupsLength = lockups.length;
        for (uint256 i; i < lockupsLength; i++) {
            balance += ITokenLockup(lockups[i]).balanceOf(account);
        }
        return balance;
    }