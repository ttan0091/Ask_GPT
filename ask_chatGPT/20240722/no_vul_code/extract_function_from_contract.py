import os
import re

script_dir = os.path.dirname(os.path.abspath(__file__))
formatted_code_dir = os.path.abspath(os.path.join(script_dir, 'Top200_contract'))
output_dir = os.path.abspath(os.path.join(script_dir, 'no_vul_code_1'))

if not os.path.exists(output_dir):
    os.makedirs(output_dir)

def find_matching_bracket(code, start_index):
    stack = 0
    for index in range(start_index, len(code)):
        if code[index] == '{':
            stack += 1
        elif code[index] == '}':
            stack -= 1
            if stack == 0:
                return index
    return -1

def extract_functions(code):
    pattern = re.compile(r'function\s+\w+\s*\([^)]*\)\s*.*?{', re.DOTALL)
    matches = pattern.finditer(code)
    functions = []
    
    for match in matches:
        start = match.start()
        end = find_matching_bracket(code, match.end() - 1)
        if end != -1:
            functions.append(code[start:end + 1])
    
    return functions

def process_file(file_path, output_dir):
    with open(file_path, 'r', encoding='utf-8') as file:
        code = file.read()
        functions = extract_functions(code)
        
        for function in functions:
            function_name = re.search(r'function\s+(\w+)', function).group(1)
            new_filename = f"{os.path.splitext(os.path.basename(file_path))[0]}_{function_name}.sol"
            new_file_path = os.path.join(output_dir, new_filename)
            
            with open(new_file_path, 'w', encoding='utf-8') as output_file:
                output_file.write(function)

def main():
    for root, _, files in os.walk(formatted_code_dir):
        for filename in files:
            if filename.endswith(".sol"):
                file_path = os.path.join(root, filename)
                process_file(file_path, output_dir)
    
    print("所有函数已经提取并保存到 no_vul_code_1 文件夹中。")

if __name__ == "__main__":
    main()