#!/usr/bin/env bash
# 批量收集 Gaussian LOG 中的 Job cpu time。
# I/O: *.log -> total_time.txt
# Requires: grep
# Note: 只汇总 CPU time 文本。

rm -f total_time.txt
for inf in *.log
do
echo Processing ${inf} ...
echo ${inf} >> total_time.txt
cat ${inf} | grep " Job cpu time:" |tee -a total_time.txt
done