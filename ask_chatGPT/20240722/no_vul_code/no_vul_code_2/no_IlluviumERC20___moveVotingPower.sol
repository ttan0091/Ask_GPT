function __moveVotingPower(address _from, address _to, uint256 _value) private {
    // if there is no move (`_from == _to`) or there is nothing to move (`_value == 0`)
    if(_from == _to || _value == 0) {
      // return silently with no action
      return;
    }

    // if source address is not zero - decrease its voting power
    if(_from != address(0)) {
      // read current source address voting power
      uint256 _fromVal = getVotingPower(_from);

      // calculate decreased voting power
      // underflow is not possible by design:
      // voting power is limited by token balance which is checked by the callee
      uint256 _toVal = _fromVal - _value;

      // update source voting power from `_fromVal` to `_toVal`
      __updateVotingPower(_from, _fromVal, _toVal);
    }

    // if destination address is not zero - increase its voting power
    if(_to != address(0)) {
      // read current destination address voting power
      uint256 _fromVal = getVotingPower(_to);

      // calculate increased voting power
      // overflow is not possible by design:
      // max token supply limits the cumulative voting power
      uint256 _toVal = _fromVal + _value;

      // update destination voting power from `_fromVal` to `_toVal`
      __updateVotingPower(_to, _fromVal, _toVal);
    }
  }