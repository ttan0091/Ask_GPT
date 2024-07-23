function _isMinterOwnGov(address the_address) internal view returns (bool) {
        return (the_address == timelock_address || the_address == owner || minters[the_address]);
    }