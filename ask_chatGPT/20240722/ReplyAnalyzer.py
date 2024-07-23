import json
import os

class ReplyAnalyzer:
    def __init__(self, file_path, output_file,id,prompt):
        self.file_path = file_path
        self.output_file = output_file
        self.yes_count = 0
        self.no_count = 0
        self.total_count = 0
        self.id = id
        self.prompt = prompt
    
    def load_data(self):
        with open(self.file_path, 'r') as file:
            self.data = json.load(file)
    
    def analyze_replies(self):
        for item in self.data:
            reply = item["reply"].strip().split()
            for word in reply:
                if word.lower() == "yes":
                    self.yes_count += 1
                    self.total_count += 1
                    break
                elif word.lower() == "no":
                    self.no_count += 1
                    self.total_count += 1
                    break
    
    def calculate_percentages(self):
        if self.total_count > 0:
            yes_percentage = (self.yes_count / self.total_count) * 100
            no_percentage = (self.no_count / self.total_count) * 100
        else:
            yes_percentage = 0
            no_percentage = 0
        return yes_percentage, no_percentage
    
    def save_results(self):
        yes_percentage, no_percentage = self.calculate_percentages()
        results = {
            "Id":self.id,
            "Prompt":self.prompt,
            "Yes": yes_percentage,
            "No": no_percentage
        }
        # 如果文件存在，就读取旧数据
        if os.path.exists(self.output_file):
            with open(self.output_file, 'r') as file:
                data = json.load(file)
        else:
            data = []
        # 添加新结果
        data.append(results)
        # 写入文件
        with open(self.output_file, 'w') as file:
            json.dump(data, file, indent=4)
        # print(f"Results saved to {self.output_file}")

    def run_analysis(self):
        self.load_data()
        self.analyze_replies()
        self.save_results()

# 使用示例
script_dir = os.path.dirname(__file__)
data_path = os.path.join(script_dir, "results_gpt_3.5_without_no_disturbance.json")
output_file = os.path.join(script_dir, "analysis_results.json")
id = "1"
prompt = "aaaa"

#  阳性代码：
# 90 个经过扰动的 prompt：
# Yes: 12.09%
# No: 87.91%

# 同一个 promot90 次：
# Yes: 23.33%
# No: 76.67%

#  换一个 prompt 90 次：
# Yes: 0.00%
# No: 100.00%


# 阴性代码
# 90 个经过扰动的 prompt：
# Yes: 27.47%
# No: 72.53%
