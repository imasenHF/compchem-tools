#!/usr/bin/env bash
# 使用 Multiwfn 提取 Gaussian LOG 最终几何并批量写为 GJF。
# I/O: *.log -> *.gjf
# Requires: Multiwfn
# Note: 适用于后续单点或其他计算的结构转存。

icc=0
nfile=`ls *.log|wc -l`
for inf in *.log
do
((icc++))
echo Converting ${inf} to ${inf//log/gjf} ... \($icc of $nfile\)
Multiwfn ${inf} << EOF > /dev/null
100
2
10
${inf//log/gjf}
0
q
EOF
done