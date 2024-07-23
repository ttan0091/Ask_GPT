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

# 初始化文件名包含*的统计字典
star_stats = {
    'vul': {
        '1_star': {'yes': 0, 'no': 0},
        '2_star': {'yes': 0, 'no': 0},
        '3_star': {'yes': 0, 'no': 0}
    },
    'no': {
        '1_star': {'yes': 0, 'no': 0},
        '2_star': {'yes': 0, 'no': 0},
        '3_star': {'yes': 0, 'no': 0}
    }
}
# 统计 question_id 为 3 的文件名包含*的 yes 和 no 数量
# count_star1 = 0
# count_star2 = 0
for result in results:
    question_id = result['question_header_id']
    reply = result['reply'].lower()
    file_name = result['file_name']
    if question_id == 3:
        
        if file_name.startswith('vul_'):
            if file_name.split('_')[1] == '3':
                # print(file_name)
                prefix = 'vul'
                # count_star1 += 1
            else:
                continue
        elif file_name.startswith('no_'):
            prefix = 'no'
            # count_star2 += 1
        else:
            continue
        
        # 通过分割文件名最后一个 _ 后面的内容来判断 * 的数量
        star_part = file_name.split('_')[-1]
        
        if '*' in star_part and '**' not in star_part and '***' not in star_part:
            star_key = '1_star'
        elif '**' in star_part and '***' not in star_part:
            star_key = '2_star'
        elif '***' in star_part:
            star_key = '3_star'
        else:
            continue
        
        if reply == 'yes':
            star_stats[prefix][star_key]['yes'] += 1
        elif reply == 'no':
            star_stats[prefix][star_key]['no'] += 1

# 打印包含*的统计结果
print('-----------------------------------')
print('Question ID = 3, * Star Stats')

for prefix, stats in star_stats.items():
    print(f'Prefix: {prefix}')
    for star, counts in stats.items():
        total = counts['yes'] + counts['no']
        yes_ratio = counts['yes'] / total if total > 0 else 0
        no_ratio = counts['no'] / total if total > 0 else 0
        print(f'  {star}:')
        print(f"    Yes: {counts['yes']} ({yes_ratio:.2%})")
        print(f"    No: {counts['no']} ({no_ratio:.2%})")
    print('-----------------------------------')

# 生成柱状图
fig, ax = plt.subplots(figsize=(14, 8))
labels = ['1*', '2**', '3***']
x = range(len(labels))
width = 0.35

# vul_ 开头的条目
yes_values_vul = [star_stats['vul']['1_star']['yes'], star_stats['vul']['2_star']['yes'], star_stats['vul']['3_star']['yes']]
no_values_vul = [star_stats['vul']['1_star']['no'], star_stats['vul']['2_star']['no'], star_stats['vul']['3_star']['no']]

# no_ 开头的条目
yes_values_no = [star_stats['no']['1_star']['yes'], star_stats['no']['2_star']['yes'], star_stats['no']['3_star']['yes']]
no_values_no = [star_stats['no']['1_star']['no'], star_stats['no']['2_star']['no'], star_stats['no']['3_star']['no']]

# 绘制 vul_ 开头的条目
ax.bar([p - width/2 for p in x], yes_values_vul, width, label='vul_ Yes', color='g')
ax.bar([p - width/2 for p in x], no_values_vul, width, bottom=yes_values_vul, label='vul_ No', color='r')

# 绘制 no_ 开头的条目
ax.bar([p + width/2 for p in x], yes_values_no, width, label='no_ Yes', color='b')
ax.bar([p + width/2 for p in x], no_values_no, width, bottom=yes_values_no, label='no_ No', color='orange')

# 设置 x 轴标签和标题
ax.set_xlabel('Star Categories')
ax.set_ylabel('Counts')
ax.set_title('Yes/No Counts for Question ID 3 with Different Star Categories')
ax.set_xticks(x)
ax.set_xticklabels(labels)
ax.legend()

plt.show()