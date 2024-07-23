function initialize(address _childChain, address _token) public {
        // Todo: once BorValidator(@0x1000) contract added uncomment me
        // require(msg.sender == address(0x1000));
        require(!isInitialized, "The contract is already initialized");
        isInitialized = true;
        token = _token;
        _transferOwnership(_childChain);
    }