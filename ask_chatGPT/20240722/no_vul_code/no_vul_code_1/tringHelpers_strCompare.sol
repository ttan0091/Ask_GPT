function strCompare(string memory _a, string memory _b) internal pure returns (int _returnCode) {
        bytes memory a = bytes(_a);
        bytes memory b = bytes(_b);
        uint minLength = a.length;
        if (b.length < minLength) {
            minLength = b.length;
        }
        for (uint i = 0; i < minLength; i ++) {
            if (a[i] < b[i]) {
                return -1;
            } else if (a[i] > b[i]) {
                return 1;
            }
        }
        if (a.length < b.length) {
            return -1;
        } else if (a.length > b.length) {
            return 1;
        } else {
            return 0;
        }
    }