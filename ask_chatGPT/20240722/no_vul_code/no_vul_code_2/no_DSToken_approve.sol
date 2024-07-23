function approve(address guy, uint wad) public stoppable returns (bool) {
        return super.approve(guy, wad);
    }