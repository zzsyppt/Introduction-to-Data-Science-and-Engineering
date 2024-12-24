# 合并数据文件脚本
import os
import pandas as pd

folder_path = "./" 
output_file = "users_combined_info.csv"

# 获取所有目标文件的文件名
csv_files = [
    f for f in os.listdir(folder_path) 
    if f.startswith("users_combined_info_500_part_") and f.endswith(".csv")
]

# 排序文件（确保按顺序合并）
csv_files.sort()

# 读取并合并所有CSV文件
combined_df = pd.concat([pd.read_csv(os.path.join(folder_path, file)) for file in csv_files])

# 将合并后的数据保存到新文件
combined_df.to_csv(output_file, index=False, encoding="utf-8")

print(f"所有文件已成功合并到本文件夹下的 {output_file}")
