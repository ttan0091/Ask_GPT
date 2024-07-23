function setWallet(address _wallet) public onlyOwner {
        require(_wallet != address(0x0));
        wallet = _wallet;
        emit WalletUpdated(_wallet);
    }