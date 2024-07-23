function addToWhitelistMultiple(address[] _addresses) public onlyAdmin {
        for (uint i; i < _addresses.length; i++) {
            pWhitelist(_addresses[i]);
        }
    }