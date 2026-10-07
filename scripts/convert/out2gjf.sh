#!/usr/bin/env bash
# 使用 Multiwfn 批量从 OUT 文件提取几何并写为 GJF。
# I/O: *.out -> *.gjf
# Requires: Multiwfn
# Note: 适用于 Multiwfn 能识别的输出文件。

icc=0
nfile=`ls *.out|wc -l`
for inf in *.out
do
((icc++))
echo Converting ${inf} to ${inf//out/gjf} ... \($icc of $nfile\)
Multiwfn ${inf} << EOF > /dev/null
100
2
10
${inf//out/gjf}
0
q
EOF
done