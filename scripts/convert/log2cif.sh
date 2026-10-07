#!/usr/bin/env bash
# 使用 Multiwfn 批量将 Gaussian LOG 转换为 CIF。
# I/O: *.log -> *.cif
# Requires: Multiwfn
# Note: 格式转换依赖 Multiwfn。

icc=0
nfile=`ls *.log|wc -l`
for inf in *.log
do
((icc++))
echo Converting ${inf} to ${inf//log/cif} ... \($icc of $nfile\)
Multiwfn ${inf} << EOF > /dev/null
100
2
33
${inf//log/cif}
0
q
EOF
done