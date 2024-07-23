function isClaimed(uint256 index) public view returns (bool) {
        return claimed.get(index);
    }