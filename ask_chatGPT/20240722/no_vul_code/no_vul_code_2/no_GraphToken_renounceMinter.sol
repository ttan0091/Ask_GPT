function renounceMinter() external {
        _removeMinter(msg.sender);
    }