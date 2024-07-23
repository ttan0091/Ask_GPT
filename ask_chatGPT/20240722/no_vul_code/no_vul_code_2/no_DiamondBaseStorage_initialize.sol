function initialize (
    address target,
    bytes memory data
  ) private {
    require(
      (target == address(0)) == (data.length == 0),
      'DiamondBase: invalid initialization parameters'
    );

    if (target != address(0)) {
      if (target != address(this)) {
        require(
          target.isContract(),
          'DiamondBase: initialization target has no code'
        );
      }

      (bool success, ) = target.delegatecall(data);

      if (!success) {
        assembly {
          returndatacopy(0, 0, returndatasize())
          revert(0, returndatasize())
        }
      }
    }
  }