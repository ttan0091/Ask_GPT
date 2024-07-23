function getTransactionIds(uint from, uint to, bool pending, bool executed)
    public
    constant
    returns (uint[] _transactionIds)
    {
        uint end = to > transactionCount? transactionCount: to;
        uint[] memory transactionIdsTemp = new uint[](end - from);
        uint count = 0;
        uint i;
        for (i = from; i < to; i++) {
            if ((pending && !transactions[i].executed)
                || (executed && transactions[i].executed))
            {
                transactionIdsTemp[count] = i;
                count += 1;
            }
        }
        _transactionIds = new uint[](count);
        for (i = 0; i < count; i++)
            _transactionIds[i] = transactionIdsTemp[i];
    }