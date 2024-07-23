function removeSwapToken(address contractAddress, uint256 supplyDecrement)
        public
    {
        require(bridgeRoles.has(msg.sender), "Unauthorized");
        require(isContract(contractAddress), "Address is not contract.");
        require(
            swapTokens[contractAddress].tokenContract != address(0),
            "Swap token not supported"
        );

        // If the decrement is less than the current supply, decrement it from the current supply.
        // Otherwise, if the decrement is greater than or equal to the current supply, delete the mapping value.
        if (swapTokens[contractAddress].supply > supplyDecrement) {
            swapTokens[contractAddress].supply =
                swapTokens[contractAddress].supply -
                supplyDecrement;
        } else {
            delete swapTokens[contractAddress];
        }
        emit RemoveSwapToken(contractAddress, supplyDecrement);
    }