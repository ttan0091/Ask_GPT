function activeMode() public onlyOwner {
        activeStatus = true;
        emit Active(msg.sender);
    }