import requests
import os
import json
import time
from concurrent.futures import ThreadPoolExecutor, as_completed

script_dir = os.path.dirname(os.path.abspath(__file__))
result_path = os.path.join(script_dir, "results.json")
api_key_path = os.path.join(script_dir, '..','api_key.txt')
code_data_path1 = os.path.join(script_dir, 'vul_code', 'vul_code_3')
code_data_path2 = os.path.join(script_dir, 'no_vul_code', 'no_vul_code_3')
query_data_path = os.path.join(script_dir, 'input_query.json')

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

def read_code_files(code_paths):
    code_files = []
    for path in code_paths:
        for file_name in os.listdir(path):
            if file_name.endswith('.sol'):
                file_path = os.path.join(path, file_name)
                with open(file_path, 'r', encoding='utf-8') as file:
                    code = file.read()
                    code_files.append({"file_name": file_name, "code": code})
    return code_files

def prompt_single_yes_no_question(question:str, code:str) -> str:
    question_template = f"""Does the following smart contract code "{question}"? Answer only "Yes" or "No".

    {code}
    """
    return question_template

def process_query(api_key, query, code_file):
    question_header = query['description1']
    question_id = query['id']
    question = prompt_single_yes_no_question(question_header, code_file['code'])
    print(f"Processing question: {question_id} for file: {code_file['file_name']}")
    response = ask_chatgpt(api_key, question)

    if response:
        reply = response['choices'][0]['message']['content']
        result = {
            "question_header_id": query['id'],
            "file_name": code_file['file_name'],
            "reply": reply
        }
        # 立即写入结果到 results.json 文件
        with open(result_path, 'a', encoding='utf-8') as output_file:
            output_file.write(json.dumps(result, ensure_ascii=False, indent=4) + ",\n")
        return result
    return None

def main():
    api_key = get_api_key()
    # 读取代码数据
    with open(query_data_path, 'r', encoding='utf-8') as file:
        query_data = json.load(file)

    # 读取所有.sol文件的代码
    code_files = read_code_files([code_data_path1, code_data_path2])

    results = []

    # 使用线程池进行并行查询
    with ThreadPoolExecutor(max_workers=10) as executor:
        future_to_query = {executor.submit(process_query, api_key, query, code_file): (query, code_file) for query in query_data for code_file in code_files}
        for future in as_completed(future_to_query):
            result = future.result()
            if result:
                results.append(result)

    print("Processing complete.")

if __name__ == "__main__":
    # 确保 results.json 文件的存在，如果不存在则创建
    if not os.path.exists(result_path):
        with open(result_path, 'w', encoding='utf-8') as output_file:
            output_file.write("[\n")
    main()
    # 在文件末尾添加关闭的方括号
    with open(result_path, 'a', encoding='utf-8') as output_file:
        output_file.write("\n]")