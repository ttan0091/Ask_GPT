function allowance(address owner, address spender) external view returns (uint) {
        owner; spender; // Shh
        delegateToViewAndReturn();
    }