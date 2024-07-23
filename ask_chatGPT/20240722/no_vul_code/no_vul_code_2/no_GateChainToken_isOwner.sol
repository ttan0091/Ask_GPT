function isOwner(address add) public view returns (bool) {
      if (add == owner) {
        return true;
      } else return false;
    }