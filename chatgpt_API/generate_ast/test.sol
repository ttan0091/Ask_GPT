// // SPDX-License-Identifier: MIT
// pragma solidity ^0.8.21;
// contract FunctionTypes{
//     uint256 public number = 5;
//     function add() external {
//         number = number + 1;
//     }
// }


pragma solidity ^0.8.0;

interface IERC20 {
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    function approve(address spender, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
}

contract VulnerableToken is IERC20 {
    mapping(address => uint256) public balances;
    mapping(address => mapping(address => uint256)) public allowed;

    uint256 public totalSupply = 1000000; // 假设初始供应量为100万

    constructor() {
        balances[msg.sender] = totalSupply; // 将初始代币余额赋给合约创建者
    }

    function transferFrom(address sender, address recipient, uint256 amount) external override returns (bool) {
        require(amount <= balances[sender], "Insufficient balance");
        require(amount <= allowed[sender][msg.sender], "Insufficient allowance");

        balances[sender] -= amount;
        balances[recipient] += amount;
        // 漏洞在这里：没有清除批准的数量
        // allowed[sender][msg.sender] -= amount; // 正确做法是在这里减去转移的数额

        return true;
    }

    function approve(address spender, uint256 amount) external override returns (bool) {
        allowed[msg.sender][spender] = amount;
        return true;
    }

    function allowance(address owner, address spender) external view override returns (uint256) {
        return allowed[owner][spender];
    }
}
