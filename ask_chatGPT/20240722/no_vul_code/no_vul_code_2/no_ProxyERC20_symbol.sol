function symbol() public view returns (string){
         // Immutable static call from target contract
        return IERC20(target).symbol();
    }