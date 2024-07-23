function recoverERC20(address tokenAddress, uint256 tokenAmount) external {
        require(msg.sender == _beneficiary, "Must be called by the beneficiary");

        // Cannot recover the staking token or the rewards token
        require(tokenAddress != _FXS_contract_address, "Cannot withdraw the FXS through this function");
        ERC20(tokenAddress).transfer(_beneficiary, tokenAmount);
    }