function _implementation() internal view virtual override returns (address) {
        return IBeacon(_beacon()).implementation();
    }