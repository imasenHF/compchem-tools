#!/usr/bin/env bash
# 使用 Multiwfn 批量将 XYZ 转换为 Gaussian GJF。
# I/O: *.xyz -> *.gjf
# Requires: Multiwfn
# Note: 输出计算级别仍需人工检查。

icc=0
nfile=`ls *.xyz|wc -l`
for inf in *.xyz
do
((icc++))
echo Converting ${inf} to ${inf//xyz/gjf} ... \($icc of $nfile\)
Multiwfn ${inf} << EOF > /dev/null
100
2
10
${inf//xyz/gjf}
0
q
EOF
done