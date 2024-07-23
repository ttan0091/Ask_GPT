function resetMode() public onlyOwner {
        activeStatus = false;
        emit Reset(msg.sender);
    }