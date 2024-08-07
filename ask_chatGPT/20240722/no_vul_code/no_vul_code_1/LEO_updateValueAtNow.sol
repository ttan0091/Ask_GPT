function updateValueAtNow(Checkpoint[] storage checkpoints, uint _value
    ) internal  {
        if ((checkpoints.length == 0)
        || (checkpoints[checkpoints.length -1].fromBlock < block.number)) {
               Checkpoint storage newCheckPoint = checkpoints[ checkpoints.length++ ];
               newCheckPoint.fromBlock =  uint256(block.number);
               newCheckPoint.value = uint256(_value);
           } else {
               Checkpoint storage oldCheckPoint = checkpoints[checkpoints.length-1];
               oldCheckPoint.value = uint256(_value);
           }
    }