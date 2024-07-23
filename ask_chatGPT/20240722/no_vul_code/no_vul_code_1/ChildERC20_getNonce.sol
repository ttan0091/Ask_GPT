function getNonce(address user) public view returns (uint256 nonce) {
        nonce = nonces[user];
    }