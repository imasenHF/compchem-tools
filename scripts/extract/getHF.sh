#!/usr/bin/env bash
# 从 Gaussian archive 段批量提取 HF energy。
# I/O: *.log -> HF.txt
# Requires: grep, sed
# Note: 依赖 Gaussian archive 文本格式。

rm -f HF.txt
for inf in *.log
do
echo Processing ${inf} ...
HF=$(cat ${inf} | grep -A 1 '\\HF' | sed -e ':a;N;s/\n//;ta;' | sed 's/ //g;s/HF=/\n/g' | sed '1d' | cut -d'\' -f 1)
echo -e "${inf//.log}\t${HF}" |tee -a temp
echo ${inf} done!!!
done
uniq temp > HF.txt
rm -f temp
echo getHF done!!!