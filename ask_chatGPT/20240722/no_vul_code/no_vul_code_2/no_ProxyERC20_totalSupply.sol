function totalSupply() public view returns (uint256) {
        // Immutable static call from target contract
        return IERC20(target).totalSupply();
    }