#!/usr/bin/env bash
# 从 Gaussian 输出提取 Thermal correction to Gibbs Free Energy。
# I/O: *.log -> Gibbs_corr.txt
# Requires: grep, sed
# Note: 基于固定输出文本。

rm -f Gibbs_free_Energy.txt
for inf in *.log
do
echo Processing ${inf} ...
Gcorr=$(cat ${inf} | grep "Thermal correction to Gibbs Free Energy=      " | cut -d= -f 2)
echo -e "${inf//.log}\t${Gcorr}" |tee -a temp
echo ${inf} done!!!
done
uniq temp > Gibbs_corr.txt
rm -f temp
echo get Thermal correction to Gibbs Free Energy done!!!