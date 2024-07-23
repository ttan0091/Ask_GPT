function facetFunctionSelectors (
    address facet
  ) external override view returns (bytes4[] memory selectors) {
    DiamondBaseStorage.Layout storage l = DiamondBaseStorage.layout();

    selectors = new bytes4[](l.selectorCount);

    uint256 numSelectors;
    uint256 selectorIndex;

    // loop through function selectors
    for (uint256 slotIndex; selectorIndex < l.selectorCount; slotIndex++) {
      bytes32 slot = l.selectorSlots[slotIndex];

      for (uint256 selectorSlotIndex; selectorSlotIndex < 8; selectorSlotIndex++) {
        selectorIndex++;

        if (selectorIndex > l.selectorCount) {
          break;
        }

        bytes4 selector = bytes4(slot << (selectorSlotIndex << 5));

        if (facet == address(bytes20(l.facets[selector]))) {
          selectors[numSelectors] = selector;
          numSelectors++;
        }
      }
    }

    // set the number of selectors in the array
    assembly { mstore(selectors, numSelectors) }
  }