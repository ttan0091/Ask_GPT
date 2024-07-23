function setMessageSender(address sender)
        external
        onlyProxy
    {
        messageSender = sender;
    }