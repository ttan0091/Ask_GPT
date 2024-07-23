function doPause() internal {
        pauseState = !pauseState;
        emit PauseChangedTo(pauseState);
    }