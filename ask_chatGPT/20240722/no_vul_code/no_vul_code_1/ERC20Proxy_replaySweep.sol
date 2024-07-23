function replaySweep(address[] _froms, address _to) public onlySweeper {
        require(_to != address(0));
        uint256 lenFroms = _froms.length;
        uint256 sweptBalance = 0;

        for (uint256 i=0; i<lenFroms; ++i) {
            address from = _froms[i];

            if (sweptSet[from]) {
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