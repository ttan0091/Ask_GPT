function setUpgradeMaster(address master) public {
        require(master != address(0), "The provided upgradeMaster is required to be a non-empty address when setting upgrade master.");

        require(msg.sender == upgradeMaster, "Message sender is required to be the original upgradeMaster when setting (new) upgrade master.");

        upgradeMaster = master;
    }