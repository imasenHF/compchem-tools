#!/usr/bin/env bash
# 按扩展名筛选文件，并把指定末尾字符串替换为新字符串。
# I/O: 参数: ext old_suffix new_suffix -> 原地重命名
# Requires: mv
# Note: 批量改名不可逆，使用前先检查命令输出。

icc=0
nfile=`ls *.$1|wc -l`
for file in *.$1
do
((icc++))
echo "Converting ${file%} to ${file%"$2"}"$3" ... \($icc of $nfile\)"
mv "$file" "${file%"$2"}"$3""
done
echo done