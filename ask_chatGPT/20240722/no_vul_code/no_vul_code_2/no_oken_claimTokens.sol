function claimTokens(uint256 amount, address delegate, bytes32[] calldata merkleProof) external {
        bytes32 leaf = keccak256(abi.encodePacked(msg.sender, amount));
        (bool valid, uint256 index) = MerkleProof.verify(merkleProof, merkleRoot, leaf);
        require(valid, "ENS: Valid proof required.");
        require(!isClaimed(index), "ENS: Tokens already claimed.");
        
        claimed.set(index);
        emit Claim(msg.sender, amount);

        _delegate(msg.sender, delegate);
        _transfer(address(this), msg.sender, amount);
    }