import os
import random

# 定义目标文件夹
script_dir = os.path.dirname(os.path.abspath(__file__))
target_folder = os.path.abspath(os.path.join(script_dir, 'no_vul_code_3'))

# 获取文件夹中所有文件的列表
files = [os.path.join(target_folder, f) for f in os.listdir(target_folder) if os.path.isfile(os.path.join(target_folder, f))]
print(f"Found {len(files)} files.")
print(files[0])

# 按星号数量分类文件
files_by_star_count = {1: [], 2: [], 3: []}

for file_path in files:
    star_count = file_path.count('*')
    if star_count in files_by_star_count:
        files_by_star_count[star_count].append(file_path)

# 保留指定数量的文件
files_to_keep = []

# 保留包含一个星号的文件 50 个
if len(files_by_star_count[1]) > 50:
    files_to_keep.extend(random.sample(files_by_star_count[1], 50))
else:
    files_to_keep.extend(files_by_star_count[1])

# 保留包含两个星号的文件 123 个
if len(files_by_star_count[2]) > 123:
    files_to_keep.extend(random.sample(files_by_star_count[2], 123))
else:
    files_to_keep.extend(files_by_star_count[2])

# 保留包含三个星号的文件 50 个
if len(files_by_star_count[3]) > 50:
    files_to_keep.extend(random.sample(files_by_star_count[3], 50))
else:
    files_to_keep.extend(files_by_star_count[3])

# 需要删除的文件 = 总文件 - 保留的文件
files_to_delete = [file_path for file_path in files if file_path not in files_to_keep]

# 删除选中的文件
for file_path in files_to_delete:
    os.remove(file_path)

print(f"Deleted {len(files_to_delete)} files. {len(files_to_keep)} files remaining.")