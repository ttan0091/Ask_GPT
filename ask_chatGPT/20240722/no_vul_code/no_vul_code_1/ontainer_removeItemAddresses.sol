function removeItemAddresses(bytes32 id) internal{
        container[id].addresses.length = 0;
    }