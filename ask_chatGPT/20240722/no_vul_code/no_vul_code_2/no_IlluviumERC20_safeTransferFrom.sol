function safeTransferFrom(address _from, address _to, uint256 _value, bytes memory _data) public {
    // first delegate call to `unsafeTransferFrom`
    // to perform the unsafe token(s) transfer
    unsafeTransferFrom(_from, _to, _value);

    // after the successful transfer - check if receiver supports
    // ERC20Receiver and execute a callback handler `onERC20Received`,
    // reverting whole transaction on any error:
    // check if receiver `_to` supports ERC20Receiver interface
    if(AddressUtils.isContract(_to)) {
      // if `_to` is a contract - execute onERC20Received
      bytes4 response = ERC20Receiver(_to).onERC20Received(msg.sender, _from, _value, _data);

      // expected response is ERC20_RECEIVED
      require(response == ERC20_RECEIVED, "invalid onERC20Received response");
    }
  }