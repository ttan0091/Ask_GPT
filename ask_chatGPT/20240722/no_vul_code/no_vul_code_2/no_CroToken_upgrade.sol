function upgrade(uint256 value) public {

        UpgradeState state = getUpgradeState();

        require(state == UpgradeState.ReadyToUpgrade, "It's required that the upgrade state is ready.");

        // Validate input value.
        require(value > 0, "The upgrade value is required to be above 0.");

        balances[msg.sender] = balances[msg.sender].sub(value);

        // Take tokens out from circulation
        totalSupply_ = totalSupply_.sub(value);
        totalUpgraded = totalUpgraded.add(value);

        // Upgrade agent reissues the tokens
        upgradeAgent.upgradeFrom(msg.sender, value);
        emit Upgrade(msg.sender, upgradeAgent, value);
    }