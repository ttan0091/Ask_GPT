function isSupportedInterface (
    Layout storage l,
    bytes4 interfaceId
  ) internal view returns (bool) {
    return l.supportedInterfaces[interfaceId];
  }