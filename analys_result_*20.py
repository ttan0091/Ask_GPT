import json
from collections import defaultdict
import matplotlib.pyplot as plt

def analyze_results(file_path):
    with open(file_path, 'r') as f:
        data = json.load(f)
    
    prompt_stats = defaultdict(lambda: defaultdict(lambda: {'yes': 0, 'no': 0, 'total': 0}))
    
    for file_name, results in data.items():
        for result in results:
            prompt_id = result['prompt_id']
            response = result['response'].lower()
            
            if response in ['yes', 'no']:
                prompt_stats[prompt_id][file_name][response] += 1
                prompt_stats[prompt_id][file_name]['total'] += 1
    
    # 创建一个 5x4 的子图布局
    fig, axes = plt.subplots(5, 4, figsize=(40, 50))
    axes = axes.flatten()

    for idx, (prompt_id, file_stats) in enumerate(prompt_stats.items()):
        ax = axes[idx]
        file_names = list(file_stats.keys())
        yes_counts = [stats['yes'] for stats in file_stats.values()]
        no_counts = [stats['no'] for stats in file_stats.values()]
        total_counts = [stats['total'] for stats in file_stats.values()]

        bar_width = 0.35
        index = range(len(file_names))

        yes_bars = ax.bar(index, yes_counts, bar_width, label='Yes', color='#66c2a5')
        no_bars = ax.bar(index, no_counts, bar_width, bottom=yes_counts, label='No', color='#fc8d62')

        ax.set_xlabel('File Name')
        ax.set_ylabel('Count')
        ax.set_title(f'Prompt ID: {prompt_id}')
        ax.set_xticks(index)
        ax.set_xticklabels(file_names, rotation=90, ha='right')
        ax.legend()

        # 在柱状图上添加数量和比例标签
        def add_labels(bars, counts, totals):
            for bar, count, total in zip(bars, counts, totals):
                height = bar.get_height()
                ratio = count / total if total > 0 else 0
                ax.text(bar.get_x() + bar.get_width()/2, bar.get_y() + height/2,
                        f'{count}\n({ratio:.1%})',
                        ha='center', va='center', fontsize=6)

        add_labels(yes_bars, yes_counts, total_counts)
        add_labels(no_bars, no_counts, total_counts)

    plt.tight_layout()
    plt.savefig('prompt_analysis.png', dpi=300)
    plt.close()

file_path = 'results/all_files_results.json'
analyze_results(file_path)