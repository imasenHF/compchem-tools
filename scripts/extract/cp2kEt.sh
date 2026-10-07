#!/usr/bin/env bash
# 从 CP2K 输出中批量提取 Total energy 并写入制表符分隔文件。
# I/O: *.out -> Et.txt
# Requires: grep, awk
# Note: 按“Total energy:”文本匹配。

rm -f Et.txt
for inf in *.out
do
echo Processing ${inf} ...
te=$(grep "Total energy:" "${inf}" | awk -F'Total energy:[[:space:]]*' 'NF>1 {print $2}' | tail -n 1)
echo -e "${inf//.out}\t${te}" >> Et.txt
done