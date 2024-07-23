function replaceFacetSelectors (
    Layout storage l,
    IDiamondCuttable.FacetCut memory facetCut
  ) internal {
    unchecked {
      require(
        facetCut.target.isContract(),
        'DiamondBase: REPLACE target has no code'
      );

      for (uint256 i; i < facetCut.selectors.length; i++) {
        bytes4 selector = facetCut.selectors[i];
        bytes32 oldFacet = l.facets[selector];
        address oldFacetAddress = address(bytes20(oldFacet));

        require(
          oldFacetAddress != address(0),
          'DiamondBase: selector not found'
        );

        require(
          oldFacetAddress != address(this),
          'DiamondBase: selector is immutable'
        );

        require(
          oldFacetAddress != facetCut.target,
          'DiamondBase: REPLACE target is identical'
        );

        // replace old facet address
        l.facets[selector] = (oldFacet & CLEAR_ADDRESS_MASK) | bytes20(facetCut.target);
      }
    }
  }