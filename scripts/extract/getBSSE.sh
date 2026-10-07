#!/usr/bin/env bash
# 从 Gaussian 输出批量提取 BSSE energy。
# I/O: *.log -> BSSE_E.txt
# Requires: grep, sed
# Note: 依赖 Gaussian 输出中的固定文本。

rm -f BSSE_E.txt
for inf in *.log
do
echo Processing ${inf} ...
BSSE=$(cat ${inf} | grep "BSSE energy =       " | cut -d= -f 2)
echo -e "${inf//.log}\t$BSSE" |tee -a temp
echo ${inf} done!!!
done
uniq temp > BSSE_E.txt
rm -f temp
echo getBSSE_E done!!!