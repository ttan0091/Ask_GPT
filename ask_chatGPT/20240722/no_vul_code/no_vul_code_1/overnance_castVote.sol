function castVote(uint proposalId, bool support) public {
        return _castVote(msg.sender, proposalId, support);
    }