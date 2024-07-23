function decodeBlockNumber(uint128 checkpoint)
        internal
        pure
        returns (uint32)
    {
        return uint32(bytes4(bytes16(checkpoint)));
    }