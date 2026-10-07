#!/usr/bin/env bash
# 使用 Multiwfn 批量将 GJF 转换为 CIF。
# I/O: *.gjf -> *.cif
# Requires: Multiwfn
# Note: 格式转换依赖 Multiwfn 主功能 100。

icc=0
nfile=`ls *.gjf|wc -l`
for inf in *.gjf
do
((icc++))
echo Converting ${inf} to ${inf//gjf/cif} ... \($icc of $nfile\)
Multiwfn ${inf} << EOF > /dev/null
100
2
33
${inf//gjf/cif}
0
q
EOF
done