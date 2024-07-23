function increment(Counter storage counter) internal {
        unchecked {
            counter._value += 1;
        }
    }