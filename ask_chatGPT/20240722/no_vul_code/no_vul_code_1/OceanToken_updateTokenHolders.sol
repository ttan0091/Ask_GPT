function updateTokenHolders(
        address sender,
        address receiver
    )
    private
    {
        tryToAddTokenHolder(sender);
        tryToAddTokenHolder(receiver);
    }