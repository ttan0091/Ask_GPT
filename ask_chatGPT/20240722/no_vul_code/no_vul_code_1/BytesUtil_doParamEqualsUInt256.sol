function doParamEqualsUInt256(bytes memory data, uint256 i, uint256 value)
        internal
        pure
        returns (bool)
    {
        if (data.length < (36 + (i + 1) * 32)) {
            return false;
        }
        uint256 offset = 36 + i * 32;
        uint256 valuePresent;
        assembly {
            valuePresent := mload(add(data, offset))
        }
        return valuePresent == value;
    }