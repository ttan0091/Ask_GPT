function isMainFirstDay() public view returns (bool) {
        if (now > dateMainStart && now <= dateMainStart + 1 days) return true;
        return false;
    }