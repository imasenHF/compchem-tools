#!/usr/bin/env bash
# 调用 OfakeG.exe 批量将 ORCA 输出转换为可供部分 Gaussian 工作流读取的伪 Gaussian 输出。
# I/O: *.out -> 由 OfakeG.exe 决定
# Requires: OfakeG.exe
# Note: 外部程序不随本项目分发。

icc=0
nfile=`ls *.out|wc -l`
for inf in *.out
do
((icc++))
echo Converting ${inf} with OfakeG.exe ... \($icc of $nfile\)
OfakeG.exe ${inf}
done