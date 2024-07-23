function voteForSwitchBurn(bool newBurnStatus, int nonce, Signature[] memory signatures) override public {
      bytes32 _id = getNewBurnStatusId(newBurnStatus, nonce);
      generalVote(_id, signatures);
      allowBurn = newBurnStatus;
    }