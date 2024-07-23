function decodeCheckpoint(uint128 checkpoint)
        internal
        pure
        returns (uint32 blockNumber, uint96 value)
    {
        blockNumber = decodeBlockNumber(checkpoint);
        value = decodeValue(checkpoint);
    }