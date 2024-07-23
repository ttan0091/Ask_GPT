function decimals() public view returns (uint8){
         // Immutable static call from target contract
        return IERC20(target).decimals();
    }