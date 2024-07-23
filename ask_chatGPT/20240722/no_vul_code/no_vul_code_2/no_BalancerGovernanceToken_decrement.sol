function decrement(Counter storage counter) internal {
        counter._value = counter._value.sub(1);
    }