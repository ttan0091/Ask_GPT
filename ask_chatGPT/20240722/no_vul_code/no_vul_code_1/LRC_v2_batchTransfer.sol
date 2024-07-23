function batchTransfer(address[] calldata accounts, uint256[] calldata amounts)
        external
        returns (bool)
    {
        require(accounts.length == amounts.length);
        for (uint i = 0; i < accounts.length; i++) {
            require(transfer(accounts[i], amounts[i]), "transfer failed");
        }
        return true;
    }