#!/usr/bin/env bash
# 批量修改 Gaussian GJF 头部资源参数，并在第 4 行追加 IOp(9/40=4) 与 guess=read。
# I/O: *.gjf -> 原地修改
# Requires: sed
# Note: 会直接修改输入文件；参数固定，使用前应检查计算设置。

# 遍历当前目录下的所有*.txt文件
for file in *.gjf; do
    if [ -f "$file" ]; then
        # 使用sed命令在第四行末尾添加 " OPT"
		sed -i '1s/16/64/' "$file"
		sed -i '1s/32/64/' "$file"
		sed -i '2s/120/200/' "$file"
		#sed -i '3s/_.chk/.chk/' "$file"
        sed -i '4s/$/ IOp(9\/40=4) guess=read/' "$file"
        echo "已经在文件 $file 的第四行末尾添加了 ' IOp(9/40=4) guess=read'"
    fi
done