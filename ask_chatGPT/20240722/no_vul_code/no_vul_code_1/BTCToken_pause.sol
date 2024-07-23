function pause() public{
        require(itemAddressExists(PAUSERHASH, msg.sender), "wrong user to pauser");
        doPause();
    }