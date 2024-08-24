function transfer(
    IERC20 token,
    address from,
    address to,
    uint256 share
) public allowed(from) {
    // Checks
    require(to != address(0), "BentoBox: to not set"); // To avoid a bad UI from burning funds

    // Effects
    balanceOf[token][from] = balanceOf[token][from].sub(share);
    balanceOf[token][to] = balanceOf[token][to].add(share);

    emit LogTransfer(token, from, to, share);
}