function approve(address spender, uint tokens) public validLock permissionCheck returns (bool success) {

        allowed[msg.sender][spender] = tokens;

        emit Approval(msg.sender, spender, tokens);

        return true;

    }