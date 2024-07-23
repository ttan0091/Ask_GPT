function getBurn(uint burnId) public view returns (address _burner, uint256 _value, bytes _data) {
        _burner = burnList[burnId].burner;
        _value = burnList[burnId].value;
        _data = burnList[burnId].data;
    }