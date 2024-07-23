function transfer(address _to, uint _value) whenNotPaused
        validDestination(_to)
        returns (bool) {
        return super.transfer(_to, _value);
    }