function submitTransaction(address destination, uint value, bytes data) 
    public
    returns (uint transactionId)
    {
        //transaction is considered as minting if no data provided, otherwise it's owner changing transaction
        transactionId = addTransaction(destination, value, data);
        confirmTransaction(transactionId);
    }