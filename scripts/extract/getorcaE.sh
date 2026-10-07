#!/usr/bin/env bash
# 从 ORCA 输出批量提取最后一次 FINAL SINGLE POINT ENERGY。
# I/O: *.out -> getTotalE.txt
# Requires: grep, uniq
# Note: 输出文件沿用历史名称 getTotalE.txt。

rm -f TotalE.txt
rm -f getTotalE.txt
for inf in *.out
do
echo Processing ${inf} ...
orcaE=$(cat ${inf} | grep "FINAL SINGLE POINT ENERGY" | tail -n 1)
echo -e "${inf//.out}\t${orcaE}" |tee -a TotalE.txt
echo ${inf} done!!!
done
uniq TotalE.txt getTotalE.txt
rm -f TotalE.txt
echo getTotalE done!!!