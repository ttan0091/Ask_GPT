function voteForMinting(SwapData memory data, Signature[] memory signatures) override public {
      bytes32 _id = getSwapDataId(data);
      generalVote(_id, signatures);
      executeMinting(data);
    }