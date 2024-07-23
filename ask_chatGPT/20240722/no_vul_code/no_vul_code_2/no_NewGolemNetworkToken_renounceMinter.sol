function renounceMinter() public {
        _removeMinter(_msgSender());
    }