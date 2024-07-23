function setDenom(string calldata denom)
        external
        onlyRole(DEFAULT_ADMIN_ROLE)
        returns (bool)
    {
        cosmosDenom = denom;
        return true;
    }