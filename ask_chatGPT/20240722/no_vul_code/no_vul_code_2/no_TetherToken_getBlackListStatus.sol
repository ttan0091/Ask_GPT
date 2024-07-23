function getBlackListStatus(address _maker) external constant returns (bool) {
        return isBlackListed[_maker];
    }