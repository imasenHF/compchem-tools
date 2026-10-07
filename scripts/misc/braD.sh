#!/usr/bin/env bash
# 删除当前目录 GJF 文件中括号及括号内文本。
# I/O: *.gjf -> 原地修改
# Requires: sed
# Note: 会直接修改输入文件；正则规则较宽，建议先备份。

for inf in *.gjf
do
echo Processing ${inf} ...
sed 's/(.*)//' "${inf}" > tmp.txt
cat tmp.txt > "${inf}"
rm -rf tmp.txt
echo ${inf} done
done