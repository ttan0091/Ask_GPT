function setCompleted(uint completed) public restricted {
    last_completed_migration = completed;
  }