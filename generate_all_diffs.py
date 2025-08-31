import difflib
import os
import glob

def generate_diff(file1_path, file2_path, output_path):
    """生成两个文件之间的diff"""
    # 读取两个文件的内容
    # 忽略前 3 行，都是注释
    with open(file1_path, 'r', encoding='utf-8') as file1:
        lines1 = file1.readlines()[3:]
    
    with open(file2_path, 'r', encoding='utf-8') as file2:
        lines2 = file2.readlines()[3:]
    
    # 生成diff
    diff = difflib.unified_diff(lines1, lines2, fromfile=file1_path, tofile=file2_path)
    diff = list(diff)
    if not diff:
        return
    
    # 将diff写入输出文件
    with open(output_path, 'w', encoding='utf-8') as output_file:
        output_file.writelines(diff)

def generate_all_diffs(mlir_dir):
    """为目录中所有相邻的.mlir文件生成diff"""
    # 获取所有.mlir文件并按名称排序
    mlir_files = glob.glob(os.path.join(mlir_dir, "*.mlir"))
    # 过滤掉包含 "commented" 的文件
    mlir_files = [f for f in mlir_files if "commented" not in f]
    mlir_files.sort()
    
    print(f"找到 {len(mlir_files)} 个.mlir文件")
    # 检查文件数量是否足够
    if len(mlir_files) < 2:
        print("目录中需要至少有2个.mlir文件才能生成diff")
        return
    
    # 为每个相邻的文件对生成diff
    for i in range(len(mlir_files) - 1):
        file1 = mlir_files[i]
        file2 = mlir_files[i + 1]
        
        # 获取文件名（不含路径和扩展名）
        file1_name = os.path.splitext(os.path.basename(file1))[0]
        file2_name = os.path.splitext(os.path.basename(file2))[0]
        # 创建diff目录
        diff_dir = os.path.join(mlir_dir, "diff")
        os.makedirs(diff_dir, exist_ok=True)
        # 创建diff文件名
        diff_filename = f"{file1_name}_to_{file2_name}.diff"
        diff_path = os.path.join(diff_dir, diff_filename)
        
        print(f"正在生成 {file1_name} -> {file2_name} 的diff...")
        generate_diff(file1, file2, diff_path)
    
    print("所有diff文件生成完成！")

if __name__ == "__main__":
    import sys
    generate_all_diffs(sys.argv[1])
