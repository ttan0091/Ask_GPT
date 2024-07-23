function addToWhiteList(address _member) public onlyOperator returns (bool) {
        whiteListed[_member] = true;
        emit WhiteListed(_member);
        return true;
    }