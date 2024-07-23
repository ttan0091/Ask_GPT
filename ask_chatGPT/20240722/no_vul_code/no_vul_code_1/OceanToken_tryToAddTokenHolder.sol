function tryToAddTokenHolder(
        address account
    )
    private
    {
        if (!tokenHolders[account] && super.balanceOf(account) > 0)
        {
            accounts.push(account);
            tokenHolders[account] = true;
        }
    }