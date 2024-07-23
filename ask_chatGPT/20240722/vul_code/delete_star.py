import os
import shutil

script_dir = os.path.dirname(__file__)
vul_code_path_source = os.path.join(script_dir, "vul_code_1")
vul_code_path_dest = os.path.join(script_dir, "vul_code_2")

if not os.path.exists(vul_code_path_dest):
    os.makedirs(vul_code_path_dest)

for filename in os.listdir(vul_code_path_source):
    if filename.endswith(".sol"):
        # 找到最后一个下划线的位置
        last_underscore_index = filename.rfind('_')
        if last_underscore_index != -1:
            # 去掉最后的_***部分
            new_filename = filename[:last_underscore_index] + ".sol"
            source_file = os.path.join(vul_code_path_source, filename)
            dest_file = os.path.join(vul_code_path_dest, new_filename)
            shutil.copyfile(source_file, dest_file)

print("文件已成功复制并重命名。")