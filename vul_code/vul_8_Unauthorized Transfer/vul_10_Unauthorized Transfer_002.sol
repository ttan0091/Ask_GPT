function transferFrom(
    address sender,
    address recipient,
    uint256 amount
) public override returns (bool) {
    if (recipient == longShort && msg.sender == longShort) {
        super._transfer(sender, recipient, amount);
        return true;
    } else {
        return super.transferFrom(sender, recipient, amount);
    }
}