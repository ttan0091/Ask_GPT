import os

def count_files_by_star_pattern(directory):
    one_star_count = 0
    two_star_count = 0
    three_star_count = 0

    for filename in os.listdir(directory):
        if filename.endswith(".sol"):
            star_count = filename.count('*')
            if star_count == 1:
                one_star_count += 1
            elif star_count == 2:
                two_star_count += 1
            elif star_count == 3:
                three_star_count += 1

    return one_star_count, two_star_count, three_star_count

script_dir = os.path.dirname(__file__)
vul_code_path_source = os.path.join(script_dir, "vul_code_3")

one_star, two_star, three_star = count_files_by_star_pattern(vul_code_path_source)

print(f"一个*的文件数量: {one_star}")
print(f"两个*的文件数量: {two_star}")
print(f"三个*的文件数量: {three_star}")