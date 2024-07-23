function owner(Layout storage s) internal view returns (address contractOwner) {
        return s.contractOwner;
    }