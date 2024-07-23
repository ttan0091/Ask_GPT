function transferIssuer(address newIssuer) 
    public
    onlyIssuer
    notNull(newIssuer)
    {
        issuer = newIssuer;
    }