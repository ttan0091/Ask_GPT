import json
import os
# 示例 JSON 数据

script_dir = os.path.dirname(os.path.abspath(__file__))
input_data_path = os.path.join(script_dir, 'input_data.json')
output_data_path = os.path.join(script_dir, 'input_data_id.json')
#read the data
with open(input_data_path, 'r') as file:
    data = json.load(file)
# 给每条数据加上编号
numbered_data = [{"id": idx + 1, "text": text} for idx, text in enumerate(data)]

# 将结果保存到文件
with open(output_data_path, 'w') as f:
    json.dump(numbered_data, f, indent=4)