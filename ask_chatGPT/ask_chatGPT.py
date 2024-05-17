
import requests
import os
def ask_chatgpt(question):
    # get api key
    script_dir = os.path.dirname(os.path.abspath(__file__))
    api_key_path = os.path.join(script_dir, 'api_key.txt')
    
    try:
        with open(api_key_path, 'r') as file:
            api_key = file.read().strip()
    except FileNotFoundError:
        print(f"File not found: {api_key_path}")
        return None
    url = "https://api.openai.com/v1/chat/completions"
    headers = {
        "Authorization": f"Bearer {api_key}",
        "Content-Type": "application/json",
    }
    data = {
        "model": "gpt-3.5-turbo-0125",
        "messages": [
            {"role": "user", "content": question}
        ],
        "temperature": 0
    }

    response = requests.post(url, json=data, headers=headers)
    return response.json()

# sent a question to the GPT-3 model
question = """
Does the following smart contract code add or check approval via require/if statements before the token transfer,
and there is no clear/reset of the approval when the transfer finishes its main branch or encounters exceptions? Answer only "Yes" or "No".
You can mimic answering them in the background five times and provide me with the most frequently appearing answer.
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
"""

# get the answer from the GPT-3 model
answer = ask_chatgpt(question)
print(answer['choices'][0]['message']['content'])




