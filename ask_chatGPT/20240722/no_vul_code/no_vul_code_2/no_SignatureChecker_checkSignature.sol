function checkSignature(bytes32 digest, Signature memory sig) public pure {
          if (sig.signature.length != 65) {
              revert("ECDSA: invalid signature length");
          }

          // Divide the signature in r, s and v variables
          bytes32 r;
          bytes32 s;
          uint8 v;

          bytes memory signature = sig.signature;

          // ecrecover takes the signature parameters, and the only way to get them
          // currently is to use assembly.
          // solhint-disable-next-line no-inline-assembly
          assembly {
              r := mload(add(signature, 0x20))
              s := mload(add(signature, 0x40))
              v := byte(0, mload(add(signature, 0x60)))
          }

          if (
              uint256(s) >
              0x7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5D576E7357A4501DDFE92F46681B20A0
          ) {
              revert("ECDSA: invalid signature 's' value");
          }

          if (v != 27 && v != 28) {
              revert("ECDSA: invalid signature 'v' value");
          }
          bytes memory prefix = "\x19Ethereum Signed Message:\n32";
          bytes32 prefixedHash = keccak256(abi.encodePacked(prefix, digest));
          require(ecrecover(prefixedHash, v, r, s) == sig.signer, "Wrong signature");
    }