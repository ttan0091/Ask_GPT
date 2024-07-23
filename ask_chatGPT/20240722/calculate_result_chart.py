import os
import json
from collections import defaultdict
import matplotlib.pyplot as plt

# 获取脚本目录路径
script_dir = os.path.dirname(__file__)
# 获取 results.json 文件路径
result_json = os.path.join(script_dir, "results.json")

# 读取 JSON 文件
with open(result_json, 'r') as file:
    results = json.load(file)

# 初始化统计字典
stats = defaultdict(lambda: {
    'vul_eq': {'yes': 0, 'no': 0}, 
    'vul_neq': {'yes': 0, 'no': 0},
    'no_vul': {'yes': 0, 'no': 0}
})

# 统计各个 question_header_id 的 yes 和 no 数量
for result in results:
    question_id = result['question_header_id']
    reply = result['reply'].lower()
    file_name = result['file_name']
    
    if file_name.startswith('vul_'):
        vul_number = int(file_name.split('_')[1])
        if vul_number == question_id:
            key = 'vul_eq'
        else:
            key = 'vul_neq'
    elif file_name.startswith('no_'):
        key = 'no_vul'
    else:
        continue
    
    if reply == 'yes':
        stats[question_id][key]['yes'] += 1
    elif reply == 'no':
        stats[question_id][key]['no'] += 1

# 生成汇总柱状图
fig, ax = plt.subplots(figsize=(18, 10))
bar_width = 0.1
bar_offset = 0.15
colors = ['b', 'g', 'r']

# 生成每个 question_id 的柱状图
for i, question_id in enumerate(range(1, 11)):
    if question_id not in stats:
        continue
    
    vul_eq_stats = stats[question_id]['vul_eq']
    vul_neq_stats = stats[question_id]['vul_neq']
    no_vul_stats = stats[question_id]['no_vul']
    
    # yes_values = [vul_eq_stats['yes'], vul_neq_stats['yes'], no_vul_stats['yes']]
    # no_values = [vul_eq_stats['no'], vul_neq_stats['no'], no_vul_stats['no']]
    yes_values = [vul_eq_stats['yes']]
    no_values = [vul_eq_stats['no']]
    
    # 创建每个类别的柱状图
    for j, (yes, no, color) in enumerate(zip(yes_values, no_values, colors)):
        ax.bar(i + j * bar_offset, yes, bar_width, label=f'QID {question_id} Yes' if i == 0 else "", color=color, alpha=0.6)
        ax.bar(i + j * bar_offset, no, bar_width, bottom=yes, label=f'QID {question_id} No' if i == 0 else "", color=color, alpha=0.3)

# 设置 x 轴标签和标题
ax.set_xlabel('Question ID')
ax.set_ylabel('Counts')
ax.set_title('Yes/No Counts for Each Question ID')
ax.set_xticks([i + bar_offset for i in range(10)])
ax.set_xticklabels(range(1, 11))
ax.legend()

plt.show()