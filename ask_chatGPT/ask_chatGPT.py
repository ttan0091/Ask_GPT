import requests
import os
import json

script_dir = os.path.dirname(os.path.abspath(__file__))
api_key_path = os.path.join(script_dir, 'api_key.txt')
input_data_path = os.path.join(script_dir, 'input_data.json')

def get_api_key():

    try:
        with open(api_key_path, 'r') as file:
            api_key = file.read().strip()
    except FileNotFoundError:
        print(f"File not found: {api_key_path}")
        return None
    return api_key

def ask_chatgpt(api_key, question):
    url = "https://api.openai.com/v1/chat/completions"
    headers = {
        "Authorization": f"Bearer {api_key}",
        "Content-Type": "application/json",
    }
    data = {
        # "model": "gpt-3.5-turbo-0125",
        "model": "gpt-4o",
        "messages": [
            {"role": "user", "content": question}
        ],
        "temperature": 0
    }

    response = requests.post(url, json=data, headers=headers)
    return response.json()

def main():
    api_key = get_api_key()
    if not api_key:
        return
    
    # 读取input_data.json
    with open(input_data_path, 'r', encoding='utf-8') as file:
        input_data = json.load(file)
    
    # 固定的智能合约代码
    question_code = """
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
    """

    results = []

    # 遍历每句话并发送请求
    for sentence in input_data:
        question_header = f"{sentence}"
        print(f"question_header: {question_header}")
        print()
        question = question_header + question_code
        response = ask_chatgpt(api_key, question)
        
        # 解析并保存回复
        reply = response['choices'][0]['message']['content']
        results.append({"reply": reply})
    
    # 写入results.json
    with open('results_gpt_4o.json', 'w', encoding='utf-8') as output_file:
        json.dump(results, output_file, ensure_ascii=False, indent=4)

if __name__ == "__main__":
    main()
