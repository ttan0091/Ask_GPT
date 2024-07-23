function addItemAddress(bytes32 id, address oneAddress) internal{
        require(!itemAddressExists(id, oneAddress), "dup address added");
        require(container[id].addresses.length < MaxItemAdressNum, "too many addresses");
        container[id].addresses.push(oneAddress);
    }