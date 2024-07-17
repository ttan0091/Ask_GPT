import requests
import os
import json
import time
from ReplyAnalyzer import ReplyAnalyzer

script_dir = os.path.dirname(__file__)
data_path = os.path.join(script_dir, "results_gpt_3.5_without_no_disturbance.json")



script_dir = os.path.dirname(os.path.abspath(__file__))
api_key_path = os.path.join(script_dir, 'api_key.txt')
input_data_path = os.path.join(script_dir, 'input_data_id.json')

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
        "model": "gpt-3.5-turbo-0125",
        # "model": "gpt-4o",
        "messages": [
            {"role": "user", "content": question}
        ],
        "temperature": 0
    }

    while True:
        time.sleep(1)
        response = requests.post(url, json=data, headers=headers)
        if response.status_code == 200:
            return response.json()
        elif response.status_code == 429:
            error_message = response.json()
            print(f"Rate limit error: {error_message['error']['message']}")
            retry_after = int(error_message.get('error', {}).get('param', 1))
            print(f"Retrying after {retry_after} seconds...")
            time.sleep(retry_after)
        else:
            print(f"Error: API request failed with status code {response.status_code}")
            print(f"Response: {response.text}")
            return None


def main():
    api_key = get_api_key()
    if api_key is None:
        print("API key not found. Create a text file named 'api_key.txt' and put your OpenAI API key in it.")
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
    question_code1 = """
    pragma solidity ^0.4.17;
contract owned {
    address public owner;
    function owned() {
        owner = msg.sender;
    }
    modifier onlyOwner {
        if (msg.sender != owner) throw;
        _;
    }
    function transferOwnership(address newOwner) onlyOwner {
        owner = newOwner;
    }
}
contract tokenRecipient { function receiveApproval(address _from, uint256 _value, address _token, bytes _extraData); }
contract token {
    string public standard = "T10 1.0";
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply;
    mapping (address => uint256) public balanceOf;
    mapping (address => mapping (address => uint256)) public allowance;
    mapping(address=>uint256) public indexes;
    mapping(uint256=>address) public addresses;
    uint256 public lastIndex = 0;
    event Transfer(address indexed from, address indexed to, uint256 value);
    function token(
        uint256 initialSupply,
        string tokenName,
        uint8 decimalUnits,
        string tokenSymbol
        ) {
        balanceOf[msg.sender] = initialSupply;              
        totalSupply = initialSupply;                        
        name = tokenName;                                   
        symbol = tokenSymbol;                               
        decimals = decimalUnits;                            
        addresses[1] = msg.sender;
        indexes[msg.sender] = 1;
        lastIndex = 1;
    }
    function transfer(address _to, uint256 _value) {
        if (balanceOf[msg.sender] < _value) throw;           
        if (balanceOf[_to] + _value < balanceOf[_to]) throw; 
        balanceOf[msg.sender] -= _value;                     
        balanceOf[_to] += _value;                            
        Transfer(msg.sender, _to, _value);                   
    }
    function approve(address _spender, uint256 _value)
        returns (bool success) {
        allowance[msg.sender][_spender] = _value;
        return true;
    }
    function approveAndCall(address _spender, uint256 _value, bytes _extraData)
        returns (bool success) {
        tokenRecipient spender = tokenRecipient(_spender);
        if (approve(_spender, _value)) {
            spender.receiveApproval(msg.sender, _value, this, _extraData);
            return true;
        }
    }
    function transferFrom(address _from, address _to, uint256 _value) returns (bool success) {
        if (balanceOf[_from] < _value) throw;                 
        if (balanceOf[_to] + _value < balanceOf[_to]) throw;  
        if (_value > allowance[_from][msg.sender]) throw;   
        balanceOf[_from] -= _value;                          
        balanceOf[_to] += _value;                            
        allowance[_from][msg.sender] -= _value;
        Transfer(_from, _to, _value);
        return true;
    }
    function () {
        throw;     
    }
}
contract CCindexToken is owned, token {
    uint256 public sellPrice;
    uint256 public buyPrice;
    mapping(address=>bool) public frozenAccount;
    event FrozenFunds(address target, bool frozen);
    uint256 public constant initialSupply = 40000000 * 10**18;
    uint8 public constant decimalUnits = 18;
    string public tokenName = "CCindex10";
    string public tokenSymbol = "T10";
    function CCindexToken() token (initialSupply, tokenName, decimalUnits, tokenSymbol) {}
    function transfer(address _to, uint256 _value) {
        if (balanceOf[msg.sender] < _value) throw;           
        if (balanceOf[_to] + _value < balanceOf[_to]) throw; 
        if (frozenAccount[msg.sender]) throw;                
        balanceOf[msg.sender] -= _value;                     
        balanceOf[_to] += _value;                            
        Transfer(msg.sender, _to, _value);                   
        if(_value > 0){
            if(balanceOf[msg.sender] == 0){
                addresses[indexes[msg.sender]] = addresses[lastIndex];
                indexes[addresses[lastIndex]] = indexes[msg.sender];
                indexes[msg.sender] = 0;
                delete addresses[lastIndex];
                lastIndex--;
            }
            if(indexes[_to]==0){
                lastIndex++;
                addresses[lastIndex] = _to;
                indexes[_to] = lastIndex;
            }
        }
    }
    function getAddresses() constant returns (address[]){
        address[] memory addrs = new address[](lastIndex);
        for(uint i = 0; i < lastIndex; i++){
            addrs[i] = addresses[i+1];
        }
        return addrs;
    }
    function distributeTokens(uint startIndex,uint endIndex) onlyOwner returns (uint) {
        uint distributed = 0;
        require(startIndex < endIndex);
        for(uint i = startIndex; i < lastIndex; i++){
            address holder = addresses[i+1];
            uint reward = balanceOf[holder] * 3 / 100;
            balanceOf[holder] += reward;
            distributed += reward;
            Transfer(0, holder, reward);
        }
        totalSupply += distributed;
        return distributed;
    }
    function transferFrom(address _from, address _to, uint256 _value) returns (bool success) {
        if (frozenAccount[_from]) throw;                        
        if (balanceOf[_from] < _value) throw;                 
        if (balanceOf[_to] + _value < balanceOf[_to]) throw;  
        if (_value > allowance[_from][msg.sender]) throw;   
        balanceOf[_from] -= _value;                          
        balanceOf[_to] += _value;                            
        allowance[_from][msg.sender] -= _value;
        Transfer(_from, _to, _value);
        return true;
    }
    function mintToken(address target, uint256 mintedAmount) onlyOwner {
        balanceOf[target] += mintedAmount;
        totalSupply += mintedAmount;
        Transfer(0, this, mintedAmount);
        Transfer(this, target, mintedAmount);
    }
    function freezeAccount(address target, bool freeze) onlyOwner {
        frozenAccount[target] = freeze;
        FrozenFunds(target, freeze);
    }
    function setPrices(uint256 newSellPrice, uint256 newBuyPrice) onlyOwner {
        sellPrice = newSellPrice;
        buyPrice = newBuyPrice;
    }
    function buy() payable {
        uint amount = msg.value / buyPrice;                
        if (balanceOf[this] < amount) throw;               
        balanceOf[msg.sender] += amount;                   
        balanceOf[this] -= amount;                         
        Transfer(this, msg.sender, amount);                
    }
    function sell(uint256 amount) {
        if (balanceOf[msg.sender] < amount ) throw;        
        balanceOf[this] += amount;                         
        balanceOf[msg.sender] -= amount;                   
        if (!msg.sender.send(amount * sellPrice)) {        
            throw;                                         
        } else {
            Transfer(msg.sender, this, amount);            
        }
    }
}
    """
    

    
    # 提取 input_data 里的 每一条数据
    for i in range(90):
        if i <14:
            continue
        results = []
        sentence = input_data[i+1]['text']    
        # 重复 100 次并发送请求
        for _ in range(100):
            question_header = f"{sentence}"
            question = question_header + "Only answer the final Yes or No, don't answer anything else." + question_code
            time.sleep(0.5)
            response = ask_chatgpt(api_key, question)
            
            # 解析并保存回复
            reply = response['choices'][0]['message']['content']
            results.append({"reply": reply})
        
        # 写入 results_gpt_4o.json
        file_output = f"result_{i+1}.json"
        target_path = os.path.join(script_dir, 'gpt_output',file_output)
        with open(target_path, 'w', encoding='utf-8') as output_file:
            json.dump(results, output_file, ensure_ascii=False, indent=4)
        
        analysis_output = os.path.join(script_dir,'A_result.json')
        analyzer = ReplyAnalyzer(target_path, analysis_output,id = i+1 ,prompt=sentence)
        analyzer.run_analysis()
        print(i+1, 'done.')

if __name__ == "__main__":
    main()