function isExecutionOperator(address who) public view returns (bool) {
        return _executionOperators[who];
    }