function nonces(address owner) public view override returns (uint256) {
        return _nonces[owner].current();
    }