function getSwapDataId(SwapData memory data)
        public
        pure
        returns (bytes32 result)
    {
        result = 
            keccak256(
                abi.encode(
                    0xDA7A,
                    data.receiver,
                    data.amount,
                    data.tx.address_.workchain,
                    data.tx.address_.address_hash,
                    data.tx.tx_hash,
                    data.tx.lt                   
                )
            );
    }