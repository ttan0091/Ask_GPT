function executeTransaction(uint transactionId)
    public
    ownerExists(msg.sender)
    confirmed(transactionId, msg.sender)
    notExecuted(transactionId)
    {
        if (isConfirmed(transactionId)) {
            Transaction storage txn = transactions[transactionId];
            txn.executed = true;

            // just need multisig for minting - freely burn
            if (txn.data.length == 0) {
                //execute minting transaction
                txn.value = txn.value;
                super._mint(txn.destination, txn.value);
                Execution(transactionId);
            } else {
                //transaction that alters the owners list
                if (txn.destination.call.value(txn.value)(txn.data))
                    Execution(transactionId);
                else {
                    ExecutionFailure(transactionId);
                    txn.executed = false;
                }
            }
        }
    }