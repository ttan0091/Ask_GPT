function _moveDelegates(
        address from,
        address to,
        uint224 amount
    ) private {
        // No need to update checkpoints if the votes don't actually move between different delegates. This can be the
        // case where tokens are transferred between two parties that have delegated their votes to the same address.
        if (from == to) {
            return;
        }

        // Some users preemptively delegate their votes (i.e. before they have any tokens). No need to perform an update
        // to the checkpoints in that case.
        if (amount == 0) {
            return;
        }

        if (from != address(0)) {
            uint32 fromRepNum = numCheckpoints[from];
            uint224 fromRepOld = fromRepNum > 0 ? checkpoints[from][fromRepNum - 1].votes : 0;
            uint224 fromRepNew = fromRepOld - amount;

            _writeCheckpoint(from, fromRepNum, fromRepOld, fromRepNew);
        }

        if (to != address(0)) {
            uint32 toRepNum = numCheckpoints[to];
            uint224 toRepOld = toRepNum > 0 ? checkpoints[to][toRepNum - 1].votes : 0;
            uint224 toRepNew = toRepOld + amount;

            _writeCheckpoint(to, toRepNum, toRepOld, toRepNew);
        }
    }