



// pragma solidity ^0.8.0;

// interface IERC20 {
//     function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
//     function approve(address spender, uint256 amount) external returns (bool);
//     function allowance(address owner, address spender) external view returns (uint256);
// }

// contract VulnerableToken is IERC20 {
//     mapping(address => uint256) public balances;
//     mapping(address => mapping(address => uint256)) public allowed;

//     uint256 public totalSupply = 1000000; // 假设初始供应量为100万

//     constructor() {
//         balances[msg.sender] = totalSupply; // 将初始代币余额赋给合约创建者
//     }

//     function transferFrom(address sender, address recipient, uint256 amount) external override returns (bool) {
//         require(amount <= balances[sender], "Insufficient balance");
//         require(amount <= allowed[sender][msg.sender], "Insufficient allowance");

//         balances[sender] -= amount;
//         balances[recipient] += amount;
//         // 漏洞在这里：没有清除批准的数量
//         // allowed[sender][msg.sender] -= amount; // 正确做法是在这里减去转移的数额

//         return true;
//     }

//     function approve(address spender, uint256 amount) external override returns (bool) {
//         allowed[msg.sender][spender] = amount;
//         return true;
//     }

//     function allowance(address owner, address spender) external view override returns (uint256) {
//         return allowed[owner][spender];
//     }
// }

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20 {
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    function approve(address spender, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
}

contract TokenTransfer {
    IERC20 public token;
    address public owner;
    mapping(address => bool) public approvedAddresses;

    constructor(address _token) {
        token = IERC20(_token);
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    function approveAddress(address _addr) external onlyOwner {
        approvedAddresses[_addr] = true;
    }

    function transfer(address _to, uint256 _amount) external {
        require(approvedAddresses[msg.sender], "Not approved to transfer");

        // Transfer tokens
        require(token.transferFrom(msg.sender, _to, _amount), "Transfer failed");

    }
}
