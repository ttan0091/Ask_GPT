```solidity
function transferFrom(
    address _from,
    address _recipient,
    uint _tokenId
) 
    public
    onlyIfAlive
    hasValidKey(_from)
    onlyKeyManagerOrApproved(_tokenId)
{
    require(ownerOf(_tokenId) == _from, 'TRANSFER_FROM: NOT_KEY_OWNER');
    require(transferFeeBasisPoints < BASIS_POINTS_DEN, 'KEY_TRANSFERS_DISABLED');
    require(_recipient != address(0), 'INVALID_ADDRESS');
    
    uint fee = getTransferFee(_from, 0);
    Key storage fromKey = keyByOwner[_from];
    Key storage toKey = keyByOwner[_recipient];
    uint previousExpiration = toKey.expirationTimestamp;

    // subtract the fee from the sender's key before the transfer
    _timeMachine(_tokenId, fee, false);

    if (toKey.tokenId == 0) { 
        toKey.tokenId = _tokenId; 
        _recordOwner(_recipient, _tokenId); 
        // Clear any previous approvals 
        _clearApproval(_tokenId);
    }

    if (previousExpiration <= block.timestamp) {
        // The recipient did not have a key, or had a key but it expired. 
        // The new expiration is the sender's expiration
        toKey.expirationTimestamp = fromKey.expirationTimestamp;
        toKey.tokenId = _tokenId;
        // Reset the key Manager to the key owner
        _setKeyManagerOf(_tokenId, address(0));
        _recordOwner(_recipient, _tokenId); 
    } else {
        // The recipient has a non-expired key. We just add them the corresponding remaining time
        // SafeSub is not required since the if confirms `previousExpiration - block.timestamp` cannot underflow
        toKey.expirationTimestamp = fromKey.expirationTimestamp + previousExpiration - block.timestamp;
    }

    // Effectively expiring the key for the previous owner
    fromKey.expirationTimestamp = block.timestamp;
    // Set the tokenID to 0 for the previous owner to avoid duplicates
    fromKey.tokenId = 0;

    // trigger event
    emit Transfer(
        _from,
        _recipient,
        _tokenId
    ); 
}
```