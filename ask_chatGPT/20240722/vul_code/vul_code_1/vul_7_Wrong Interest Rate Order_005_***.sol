```solidity
function borrow(uint256 amount) external onlyMember(msg.sender) whenNotPaused nonReentrant {
    IAssetManager assetManagerContract = IAssetManager(assetManager);
    require(amount >= minBorrow, "UToken: amount less than loan size min");
    require(amount <= getRemainingLoanSize(), "UToken: amount more than loan global size max");

    uint256 fee = calculatingFee(amount);
    require(borrowBalanceView(msg.sender) + amount + fee <= maxBorrow, "UToken: amount larger than borrow limit");

    require(!checkIsOverdue(msg.sender), "UToken: Member has loans overdue");
    require(amount <= assetManagerContract.getLoanableAmount(underlying), "UToken: Not enough to lend");
    require(
        uint256(_getCreditLimit(msg.sender)) >= amount + fee,
        "UToken: The loan amount plus fee is greater than credit limit"
    );

    require(accrueInterest(), "UToken: accrue interest failed");

    uint256 borrowedAmount = borrowBalanceStoredInternal(msg.sender);

    // Set lastRepay init data
    if (accountBorrows[msg.sender].lastRepay == 0) {
        accountBorrows[msg.sender].lastRepay = getBlockNumber();
    }

    uint256 accountBorrowsNew = borrowedAmount + amount + fee;
    uint256 totalBorrowsNew = totalBorrows + amount + fee;
    uint256 oldPrincipal = accountBorrows[msg.sender].principal;

    accountBorrows[msg.sender].principal += amount + fee;
    uint256 newPrincipal = accountBorrows[msg.sender].principal;
    IUserManager(userManager).updateLockedData(msg.sender, newPrincipal - oldPrincipal, true);
    accountBorrows[msg.sender].interest = accountBorrowsNew - accountBorrows[msg.sender].principal;
    accountBorrows[msg.sender].interestIndex = borrowIndex;
    totalBorrows = totalBorrowsNew;
    // The origination fees contribute to the reserve
    totalReserves += fee;

    require(assetManagerContract.withdraw(underlying, msg.sender, amount), "UToken: Failed to withdraw");

    emit LogBorrow(msg.sender, amount, fee);
}
```