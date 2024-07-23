function freeze() public onlyOwner {
        isLocked = 1;
        
        emit Freezed();
    }