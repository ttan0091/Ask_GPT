function transfer(
        address _to,
        uint256 _value
    )
    public
    returns (bool)
    {
        bool success = super.transfer(_to, _value);
        if (success) {
            updateTokenHolders(msg.sender, _to);
        }
        return success;
    }