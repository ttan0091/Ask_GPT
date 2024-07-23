function balanceOf(address owner) public view returns (uint256) {
        // Immutable static call from target contract
        return IERC20(target).balanceOf(owner);
    }