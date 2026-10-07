#!/usr/bin/env bash
# 从 ORCA 输出批量收集激发态 STATE 行。
# I/O: *.out -> tdState.txt
# Requires: grep
# Note: 用于快速汇总 TD/激发态文本。

rm -f tdState.txt
for inf in *.out
do
echo Processing ${inf} ...
echo ${inf//.out} >> tdState.txt
cat ${inf} | grep "STATE " >> tdState.txt
echo ${inf} done!!!
done

echo Get tdState done!!!