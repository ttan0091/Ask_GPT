function exit() external override {
        withdraw(_balances[msg.sender]);

        // TODO: Add locked stakes too?

        getReward();
    }