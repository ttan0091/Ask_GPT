function pause() onlyOwner whenNotPaused public {
        paused = true;
        Pause();
    }