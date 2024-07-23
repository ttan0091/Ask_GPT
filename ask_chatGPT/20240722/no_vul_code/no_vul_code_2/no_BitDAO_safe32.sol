function safe32(uint256 n, string memory errorMessage) internal pure returns (uint256) {
		require(n < 2**32, errorMessage);
		return uint256(n);
	}