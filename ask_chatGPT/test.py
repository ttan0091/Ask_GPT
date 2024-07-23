import json
import os

def count_yes_no(data_json):
    # 解析 JSON 数据
    data = json.loads(data_json)
    
    # 初始化计数器
    yes_count = 0
    no_count = 0
    
    # 统计 'Yes' 和 'No' 的数量
    for item in data:
        yes_count += item["Yes"]
        no_count += item["No"]
    
    return yes_count, no_count

# 示例使用
script_dir = os.path.dirname(__file__) 
file_path = os.path.join(script_dir, 'No_result.json')

# 打开并读取文件内容
with open(file_path, 'r') as file:
    data_json = file.read()

yes_count, no_count = count_yes_no(data_json)
print("Yes:", yes_count)
print("No:", no_count)