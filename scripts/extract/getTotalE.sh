#!/usr/bin/env bash
# 从 CP2K 输出批量提取 Total energy。
# I/O: *.out -> getTotalE.txt
# Requires: grep, uniq
# Note: 基于“Total energy:”文本匹配。

rm -f TotalE.txt
rm -f getTotalE.txt
for inf in *.out
do
echo Processing ${inf} ...
echo ${inf//.out} >> TotalE.txt
cat ${inf} | grep "Total energy:" | cut -d: -f 2 >> TotalE.txt
echo ${inf} done!!!
done
uniq TotalE.txt getTotalE.txt
rm -f TotalE.txt
echo getTotalE done!!!