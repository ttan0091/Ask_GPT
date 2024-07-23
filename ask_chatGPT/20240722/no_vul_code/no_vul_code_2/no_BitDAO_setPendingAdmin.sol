function setPendingAdmin(address newPendingAdmin) external returns (bool) {
		if (msg.sender != admin) {
			revert('BitDAO:setPendingAdmin:illegal address');
		}
		address oldPendingAdmin = pendingAdmin;
		pendingAdmin = newPendingAdmin;

		emit NewPendingAdmin(oldPendingAdmin, newPendingAdmin);

		return true;
	}