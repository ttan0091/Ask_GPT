import os
import shutil

script_dir = os.path.dirname(__file__)
vul_code_path_source = os.path.join(script_dir, "no_vul_code_2")
vul_code_path_dest = os.path.join(script_dir, "no_vul_code_3")

# 确保目标文件夹存在
if not os.path.exists(vul_code_path_dest):
    os.makedirs(vul_code_path_dest)

# 遍历源文件夹中的所有文件
for filename in os.listdir(vul_code_path_source):
    if filename.endswith(".sol"):
        source_file = os.path.join(vul_code_path_source, filename)
        
        # 计算文件的代码行数
        with open(source_file, 'r') as file:
            lines = file.readlines()
            code_lines = [line for line in lines if line.strip() != '']
            line_count = len(code_lines)
        
        # 根据行数修改文件名
        if line_count < 10:
            new_filename = filename.replace('.sol', '_*.sol')
        elif 10 <= line_count <= 30:
            new_filename = filename.replace('.sol', '_**.sol')
        else:
            new_filename = filename.replace('.sol', '_***.sol')
        
        # 复制文件到目标文件夹
        dest_file = os.path.join(vul_code_path_dest, new_filename)
        shutil.copy(source_file, dest_file)