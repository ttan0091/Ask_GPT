function enableSweep(uint8[] _vs, bytes32[] _rs, bytes32[] _ss, address _to) public onlySweeper {
        require(_to != address(0));
        require((_vs.length == _rs.length) && (_vs.length == _ss.length));

        uint256 numSignatures = _vs.length;
        uint256 sweptBalance = 0;

        for (uint256 i=0; i<numSignatures; ++i) {
          address from = ecrecover(sweepMsg, _vs[i], _rs[i], _ss[i]);

          // ecrecover returns 0 on malformed input
          if (from != address(0)) {
            sweptSet[from] = true;

            uint256 fromBalance = erc20Store.balances(from);

            if (fromBalance > 0) {
              sweptBalance += fromBalance;

              erc20Store.setBalance(from, 0);

              erc20Proxy.emitTransfer(from, _to, fromBalance);
            }
          }
        }

        if (sweptBalance > 0) {
          erc20Store.addBalance(_to, sweptBalance);
        }
    }