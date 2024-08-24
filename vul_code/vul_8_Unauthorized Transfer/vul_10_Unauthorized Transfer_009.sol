function transferFrom(
    uint256 _projectId,
    address _from,
    address _to,
    uint256 _amount
) external override {
    _projectId; // Prevents unused var compiler and natspec complaints.

    transferFrom(_from, _to, _amount);
}