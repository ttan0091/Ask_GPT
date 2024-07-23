function delegate(address _to) public {
    // verify delegations are enabled
    require(isFeatureEnabled(FEATURE_DELEGATIONS), "delegations are disabled");
    // delegate call to `__delegate`
    __delegate(msg.sender, _to);
  }