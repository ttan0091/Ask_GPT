import json
from collections import defaultdict
import matplotlib.pyplot as plt

def analyze_results(file_path):
    with open(file_path, 'r') as f:
        data = json.load(f)
    
    file_stats = defaultdict(lambda: {'yes': 0, 'no': 0, 'total': 0})
    
    for file_name, results in data.items():
        for result in results:
            response = result['response'].lower()
            
            if response in ['yes', 'no']:
                file_stats[file_name][response] += 1
                file_stats[file_name]['total'] += 1
    
    print("\nAnalysis results for each file:")
    for file_name, counts in file_stats.items():
        yes_ratio = counts['yes'] / counts['total'] if counts['total'] > 0 else 0
        no_ratio = counts['no'] / counts['total'] if counts['total'] > 0 else 0
        print(f"  {file_name}:")
        print(f"    Yes: {counts['yes']} ({yes_ratio:.2%})")
        print(f"    No: {counts['no']} ({no_ratio:.2%})")
        print(f"    Total: {counts['total']}")
    
    # 创建可视化图表
    file_names = list(file_stats.keys())
    yes_counts = [stats['yes'] for stats in file_stats.values()]
    no_counts = [stats['no'] for stats in file_stats.values()]
    total_counts = [stats['total'] for stats in file_stats.values()]

    fig, ax = plt.subplots(figsize=(20, 10))
    bar_width = 0.35
    index = range(len(file_names))

    yes_bars = plt.bar(index, yes_counts, bar_width, label='Yes', color='#66c2a5')
    no_bars = plt.bar(index, no_counts, bar_width, bottom=yes_counts, label='No', color='#fc8d62')

    plt.xlabel('File Name')
    plt.ylabel('Count')
    plt.title('Yes and No Counts and Ratios for Each File')
    plt.xticks(index, file_names, rotation=90, ha='right')
    plt.legend()

    # 在柱状图上添加数量和比例标签
    def add_labels(bars, counts, totals):
        for bar, count, total in zip(bars, counts, totals):
            height = bar.get_height()
            ratio = count / total if total > 0 else 0
            ax.text(bar.get_x() + bar.get_width()/2, bar.get_y() + height/2,
                    f'{count}\n({ratio:.1%})',
                    ha='center', va='center', fontsize=8)

    add_labels(yes_bars, yes_counts, total_counts)
    add_labels(no_bars, no_counts, total_counts)

    plt.tight_layout()
    plt.savefig('file_analysis.png', dpi=300)
    plt.close()

file_path = 'results/all_files_results.json'
analyze_results(file_path)