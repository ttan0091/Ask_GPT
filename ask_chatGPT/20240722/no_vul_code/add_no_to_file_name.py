import os
import shutil

# 获取源文件夹和目标文件夹的路径
script_dir = os.path.dirname(os.path.realpath(__file__))    
source_dir = os.path.join(script_dir, 'no_vul_code_1')
dest_dir = os.path.join(script_dir, 'no_vul_code_2')

# 如果目标文件夹不存在，则创建它
if not os.path.exists(dest_dir):
    os.makedirs(dest_dir)

# 遍历源文件夹中的所有文件
for filename in os.listdir(source_dir):
    # 构建源文件和目标文件的完整路径
    src_file = os.path.join(source_dir, filename)
    dest_file = os.path.join(dest_dir, 'no_' + filename)
    
    # 复制文件到目标文件夹，并在文件名前添加 'no_'
    shutil.copy2(src_file, dest_file)

print("文件复制完成")