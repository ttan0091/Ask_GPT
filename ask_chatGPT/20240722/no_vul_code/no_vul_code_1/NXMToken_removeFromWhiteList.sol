function removeFromWhiteList(address _member) public onlyOperator returns (bool) {
        whiteListed[_member] = false;
        emit BlackListed(_member);
        return true;
    }